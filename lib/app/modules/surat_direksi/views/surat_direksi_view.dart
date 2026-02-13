import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/surat_direksi.dart';
import 'package:qrm_dev/app/modules/surat_direksi/controllers/surat_direksi_controller.dart';
import 'package:qrm_dev/app/modules/surat_direksi/views/create_surat_direksi_view.dart';
import 'package:qrm_dev/app/modules/surat_direksi/views/detail_sk_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class SuratDireksiView extends StatelessWidget {
  final SuratDireksiController controller = Get.put(SuratDireksiController());

  SuratDireksiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'SK Direksi',
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => CreateSuratDireksiView())?.then((data) {
                  if (data != null) {
                    controller.insertData(SuratDireksi.fromJson(data));
                  }
                });
              },
              icon: Icon(Hi.add01))
        ],
      ).appBar,
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: SearchQuery.searchInput(
                        onChanged: controller.updateSearchQuery)),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: Obx(() {
                bool isLoading = controller.isLoading.value;
                final data = controller.rxSuratDir;
                final itemWidth = MediaQuery.of(context).size.width - 30;

                if (isLoading) {
                  return Center(child: CustomLoading());
                }

                if (data.isEmpty) {
                  return Empty(
                    message: 'Tidak ada data.',
                    onTap: () => controller.getSuratDir(),
                  );
                }

                return LzListView(
                    padding: Ei.sym(v: 20),
                    onRefresh: () => controller.getSuratDir(),
                    onScroll: (scroll) {
                      if (scroll.atBottom(100)) {
                        controller.onPaginate();
                      }
                    },
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: data.map((data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final result = await Get.dialog(
                                      DetailSkView(data: data));
                                  if (result != null) {
                                    controller.updateData(
                                        SuratDireksi.fromJson(result),
                                        data.id!);
                                  }
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  width: itemWidth,
                                  padding: const EdgeInsets.all(10),
                                  decoration: CustomDecoration.validator(),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data.nama ?? 'tidak ada',
                                          style: CustomTextStyle.title(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      // Row(
                                      //   mainAxisSize: MainAxisSize.min,
                                      //   children: [
                                      //     IconButton(
                                      //       padding: EdgeInsets.zero,
                                      //       onPressed: () {
                                      //         Get.to(() =>
                                      //                 EditSkView(data: data))
                                      //             ?.then((value) {
                                      //           if (value != null) {
                                      //             controller.updateData(
                                      //                 SuratDireksi.fromJson(
                                      //                     value),
                                      //                 data.id!);
                                      //           }
                                      //         });
                                      //       },
                                      //       icon: Icon(Hi.edit01,
                                      //           color: Colors.white),
                                      //     ),
                                      //     IconButton(
                                      //       padding: EdgeInsets.zero,
                                      //       onPressed: () {
                                      //         CustomDelete.show(
                                      //           title: 'Konfirmasi Hapus',
                                      //           message:
                                      //               'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                      //           context: context,
                                      //           onConfirm: () {
                                      //             controller.deleteSK(data.id!);
                                      //           },
                                      //         );
                                      //       },
                                      //       icon: Icon(Hi.delete02,
                                      //           color: Colors.white),
                                      //     )
                                      //   ],
                                      // ),
                                      IconButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                              title: 'Konfirmasi',
                                              middleText:
                                                  'Apakah Anda yakin ingin menghapus data ini?',
                                              textConfirm: 'Ya',
                                              textCancel: 'Batal',
                                              confirmTextColor: Colors.white,
                                              buttonColor: Colors.blue,
                                              onConfirm: () {
                                                Get.back();
                                                controller.deleteSK(data.id!);
                                              },
                                            );
                                          },
                                          icon: Icon(Hi.delete01))
                                      // iosBlurActionGroup(
                                      //   onEdit: () {
                                      //     Get.to(() => EditSkView(data: data))
                                      //         ?.then((value) {
                                      //       if (value != null) {
                                      //         controller.updateData(
                                      //           SuratDireksi.fromJson(value),
                                      //           data.id!,
                                      //         );
                                      //       }
                                      //     });
                                      //   },
                                      //   onDelete: () {
                                      //     Get.defaultDialog(
                                      //       title: 'Konfirmasi',
                                      //       middleText:
                                      //           'Apakah Anda yakin ingin menghapus data ini?',
                                      //       textConfirm: 'Ya',
                                      //       textCancel: 'Batal',
                                      //       confirmTextColor: Colors.white,
                                      //       buttonColor: Colors.blue,
                                      //       onConfirm: () {
                                      //         Get.back();
                                      //         controller.deleteSK(data.id!);
                                      //       },
                                      //     );
                                      //   },
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        }).toList(),
                      ),
                      Obx(() =>
                          CustomLoading().lz.hide(!controller.isPaginate.value))
                    ]);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
