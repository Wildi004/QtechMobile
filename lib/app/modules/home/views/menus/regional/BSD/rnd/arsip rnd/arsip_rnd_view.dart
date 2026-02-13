import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/RND/Arsip%20RND/arsip_rnd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/arsip%20rnd/detail_arsip_rnd_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class ArsipRndView extends GetView<ArsipRndController> {
  const ArsipRndView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ArsipRndController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      bool isLoading = controller.isLoading.value;
      final data = controller.listArsip;

      if (isLoading) {
        return Center(child: CustomLoading());
      }

      if (data.isEmpty) {
        return Empty(
          message: 'Tidak ada Surat Keluar.',
          onTap: () => controller.getData(),
        );
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: SearchQuery.searchInput(
                      onSubmitted: controller.updateSearchQuery,
                      controller: controller.searchC,
                      hint: 'Search...'),
                ),
              ],
            ),
          ),
          Expanded(
            child: LzListView(
              padding: Ei.sym(h: 20),
              onRefresh: () => controller.getData(),
              onScroll: (scroll) {
                if (scroll.atBottom(100)) {
                  controller.onPaginate();
                }
              },
              children: [
                SizedBox(height: 20),
                ...data.generate((item, i) {
                  return ListItemAnimasi(
                    index: i,
                    beginOffset: const Offset(-0.3, 0),
                    child: CustomScalaContainer(
                      child: Touch(
                        onTap: () {
                          Get.to(() => DetailArsipRndView(data: item))
                              ?.then((value) {});
                        },
                        margin: Ei.only(b: 10),
                        child: Container(
                          width: itemWidth,
                          padding: const EdgeInsets.all(10),
                          decoration: CustomDecoration.validator(),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.nama ?? '-',
                                  overflow: TextOverflow.ellipsis,
                                  style: CustomTextStyle.title(),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  CustomDelete.show(
                                    title: 'Konfirmasi Hapus',
                                    message:
                                        'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                    context: context,
                                    onConfirm: () {
                                      controller.deleteData(item.id!);
                                    },
                                  );
                                },
                                icon: Icon(
                                  Hi.delete02,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                Obx(() =>
                    CustomLoading().lz.hide(!controller.isPaginate.value)),
              ],
            ),
          ),
        ],
      );
    });
  }
}
