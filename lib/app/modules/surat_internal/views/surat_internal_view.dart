import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/surat_internal.dart';
import 'package:qrm_dev/app/modules/surat_internal/controllers/surat_internal_controller.dart';
import 'package:qrm_dev/app/modules/surat_internal/views/form_add_surat_view.dart';
import 'package:qrm_dev/app/modules/surat_internal/views/detail_surat_internal_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class SuratInternalView extends StatelessWidget {
  final SuratInternalController controller = Get.put(SuratInternalController());

  SuratInternalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Surat Internal',
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => FormAddSuratView())?.then((data) {
                  if (data != null) {
                    controller.insertData(SuratInternal.fromJson(data));
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
                bool isLoading = controller.isloading.value;
                final suratInternal = controller.rxSuratInter;
                final itemWidth = MediaQuery.of(context).size.width - 30;
                if (isLoading) {
                  return Center(child: CustomLoading());
                }
                if (suratInternal.isEmpty) {
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
                        children: suratInternal.map((data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(() =>
                                          DetailSuratInternalView(data: data))
                                      ?.then((value) {
                                    if (value != null) {
                                      controller.updateData(
                                          SuratInternal.fromJson(value),
                                          data.id!);
                                    }
                                  });
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  width: itemWidth,
                                  padding: const EdgeInsets.all(10),
                                  decoration: CustomDecoration.validator(),
                                  child: Row(children: [
                                    Expanded(
                                      child: Text(
                                        data.nama ?? 'tidak ada',
                                        style: CustomTextStyle.title(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
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
                                              controller.deletsurat(data.id!);
                                            },
                                          );
                                        },
                                        icon: Icon(Hi.delete01)
                                        // iosBlurActionGroup(
                                        //   onEdit: () {
                                        //     Get.to(() => EditSuratInternalView(
                                        //         data: data))?.then((value) {
                                        //       if (value != null) {
                                        //         controller.updateData(
                                        //           SuratInternal.fromJson(value),
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
                                        //         controller.deletsurat(data.id!);
                                        //       },
                                        //     );
                                        //   },
                                        // ),
                                        // ),
                                        )
                                  ]),
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
