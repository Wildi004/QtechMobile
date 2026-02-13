import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Laporan%20Kerja%20IT/laporan_it_minggu_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Laporan%20Kerja%20IT/laporan_it_tanggal_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/laporan%20it/laporan_it_tanggal_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class LaporanItMingguView extends GetView<LaporanItMingguController> {
  final String encryptedMinggu;

  const LaporanItMingguView({super.key, required this.encryptedMinggu});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadDetail(encryptedMinggu);
    });

    return Scaffold(
      appBar: CustomAppbar(title: 'Laporan Harian').appBar,
      body: Obx(() {
        Get.lazyPut(() => LaporanItMingguController());
        final isLoading = controller.isLoading.value;
        final data = controller.detailList;

        if (isLoading) {
          return Center(child: CustomLoading());
        }

        if (data.isEmpty) {
          return Empty(
            message: 'Tidak ada data apa pun.',
            onTap: () => controller.loadDetail(encryptedMinggu),
          );
        }

        return Column(
          children: [
            Padding(
              padding: Ei.sym(v: 20, h: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SearchQuery.searchInput(
                      onChanged: controller.updateSearchQuery,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LzListView(
                padding: Ei.sym(h: 20),
                onRefresh: () => controller.loadDetail(encryptedMinggu),
                onScroll: (scroll) {
                  if (scroll.atBottom(100)) {
                    controller.onPaginate();
                  }
                },
                children: [
                  ...data.generate((item, i) {
                    return ListItemAnimasi(
                      index: i,
                      beginOffset: const Offset(-0.3, 0),
                      child: CustomScalaContainer(
                        child: Touch(
                          onTap: () {
                            Get.lazyPut(() => LaporanItTanggalController());
                            Get.to(
                              () => LaporanItTanggalView(
                                encryptedTglRencana:
                                    item.encryptedTglRencana ?? '',
                                encryptedPic: item.encryptedPic ?? '',
                              ),
                            );
                          },
                          margin: Ei.only(b: 10),
                          child: Container(
                            width: itemWidth,
                            padding: const EdgeInsets.all(10),
                            decoration: CustomDecoration.validator(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.tglRencana ?? 'Tidak ada',
                                  style: CustomTextStyle.title(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  item.userName ?? 'Tidak ada',
                                  style: CustomTextStyle.title(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
      }),
    );
  }
}
