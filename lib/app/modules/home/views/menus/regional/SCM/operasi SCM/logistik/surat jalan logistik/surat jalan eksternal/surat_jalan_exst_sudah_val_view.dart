import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Surat%20Jalan%20Logistik/surat%20jalan%20exst/surat_jalan_ext_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/surat%20jalan%20logistik/surat%20jalan%20eksternal/surat_jalan_exst_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class SuratJalanExstSudahValView extends GetView<SuratJalanExtController> {
  const SuratJalanExstSudahValView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SuratJalanExtController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    final icons = [
      Hi.view,
      Hi.edit01,
      Hi.delete01,
    ];

    final options = DropOption.of(
      ['Info', 'Edit', 'Delete'],
      critical: ['Delete'],
      icons: icons,
      focused: [1],
    );
    return Unfocuser(
      child: Obx(() {
        bool isLoading = controller.isLoading.value;
        final data = controller.listData;

        if (isLoading) {
          return Center(child: CustomLoading());
        }

        if (data.isEmpty) {
          return Empty(
            message: 'Tidak ada data.',
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
                padding: Ei.sym(
                  h: 20,
                ),
                onRefresh: () => controller.getData(),
                onScroll: (scroll) {
                  if (scroll.atBottom(100)) {
                    controller.onPaginate();
                  }
                },
                children: [
                  SizedBox(height: 10),
                  ...data.generate((item, i) {
                    return Droplist(
                      options: options,
                      builder: (key, action) {
                        return CustomScalaContainer(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              key:
                                  key, // penting supaya droplist tau element yg dibungkus
                              width: itemWidth,
                              padding: const EdgeInsets.all(10),
                              decoration: CustomDecoration.notValidator(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.noPo ?? 'tidak ada',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          action.show((value) {
                                            if (value.index == 0) {
                                              Get.to(() =>
                                                      SuratJalanExstDetailView(
                                                          data: item))
                                                  ?.then((value) {
                                                if (int.tryParse(
                                                        item.noHide!) !=
                                                    null) {}
                                              });
                                            } else if (value.index == 1) {
                                              // Get.to(() =>
                                              //         EditDeliveryPembPpnView(
                                              //             data: item))
                                              //     ?.then((value) {
                                              //   if (value != null) {
                                              //     final form = Get.find<
                                              //         DelPembPpnBelumValController>();
                                              //     form.updateData(
                                              //         DelPembPpn.fromJson(
                                              //             value),
                                              //         item.noHide!);
                                              //   }
                                              // });
                                            } else if (value.index == 2) {
                                              // CustomDelete.show(
                                              //   title: 'Konfirmasi Hapus',
                                              //   message:
                                              //       'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                              //   context: context,
                                              //   onConfirm: () {
                                              //     controller.deleteData(
                                              //         item.noHide ?? '');
                                              //   },
                                              // );
                                            }
                                          });
                                        },
                                        icon: Icon(Hi.leftToRightListBullet),
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                  Text(
                                    item.noBukti ?? 'tidak ada',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  10.height,
                                  Intrinsic(children: [
                                    Text(
                                      'Ditujukan :',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'Tgl :',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ]),
                                  Intrinsic(children: [
                                    Text(
                                      item.namaPerusahaan ?? 'tidak ada',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      item.tgl ?? 'tidak ada',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ])
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
