import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/data_mandor/data_mandor.dart';
import 'package:qrm_dev/app/modules/data_mandor/controllers/data_mandor_controller.dart';
import 'package:qrm_dev/app/modules/data_mandor/views/add_data_mandor_view.dart';
import 'package:qrm_dev/app/modules/data_mandor/views/detail_data_mandor_view.dart';
import 'package:qrm_dev/app/modules/data_mandor/views/edit_data_mandor_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class DataMandorView extends StatelessWidget {
  final DataMandorController controller = Get.put(DataMandorController());

  DataMandorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Data Mandor',
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => AddDataMandorView())?.then((data) {
                  if (data != null) {
                    controller.insertData(DataMandor.fromJson(data));
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
                final data = controller.rxDataMan;
                final itemWidth = MediaQuery.of(context).size.width - 30;

                if (isLoading) {
                  return Center(child: CustomLoading());
                }

                if (data.isEmpty) {
                  return Empty(
                    message: 'Tidak ada data.',
                    onTap: () => controller.getData(),
                  );
                }

                return LzListView(
                    padding: Ei.sym(v: 20),
                    onRefresh: () => controller.getData(),
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
                                onTap: () {
                                  Get.to(() => DetailDataMandorView(data: data))
                                      ?.then((value) {
                                    if (value != null) {
                                      controller.updateData(
                                          DataMandor.fromJson(value), data.id!);
                                    }
                                  });
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
                                      //         Get.to(() => EditDataMandorView(
                                      //             data: data))?.then((value) {
                                      //           if (value != null) {
                                      //             controller.updateData(
                                      //                 DataMandor.fromJson(
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
                                      //             controller.deletet(data.id!);
                                      //           },
                                      //         );
                                      //       },
                                      //       icon: Icon(Hi.delete02,
                                      //           color: Colors.white),
                                      //     )
                                      //   ],
                                      // ),
                                      iosBlurActionGroup(
                                        onEdit: () {
                                          Get.to(() => EditDataMandorView(
                                              data: data))?.then((value) {
                                            if (value != null) {
                                              controller.updateData(
                                                DataMandor.fromJson(value),
                                                data.id!,
                                              );
                                            }
                                          });
                                        },
                                        onDelete: () {
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
                                              controller.deletet(data.id!);
                                            },
                                          );
                                        },
                                      ),
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
