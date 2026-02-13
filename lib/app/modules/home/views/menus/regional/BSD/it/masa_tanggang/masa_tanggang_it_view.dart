import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/masa_tanggang.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Masa%20Tanggang%20IT/masa_tanggang_it_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/masa_tanggang/create_masa_tanggang_it_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class MasaTanggangItView extends GetView<MasaTanggangItController> {
  const MasaTanggangItView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MasaTanggangItController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Data Masa Tanggang',
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => CreateMasaTanggangItView())?.then((data) {
                  if (data != null) {
                    controller.insertData(MasaTanggang.fromJson(data));
                  }
                });
              },
              icon: Icon(Hi.add01))
        ],
      ).appBar,
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        bool isLoading = controller.isLoading.value;
        final data = controller.listMasaTanggang;

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
                            margin: Ei.only(b: 10),
                            child: Container(
                              width: itemWidth,
                              padding: const EdgeInsets.all(10),
                              decoration: CustomDecoration.validator(),
                              child: Column(
                                mainAxisAlignment: Maa.start,
                                crossAxisAlignment: Caa.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.namaHosting ?? '-',
                                          maxLines: 99,
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
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Penyedia : ${item.penyedia}',
                                    style: CustomTextStyle.subtitle(),
                                  ),
                                  Text(
                                    'Tanggal Expired : ${item.tglExpired}',
                                    style: CustomTextStyle.subtitle(),
                                  ),
                                ],
                              ),
                            )),
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
