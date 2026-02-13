import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/daftar_tkdn.dart';
import 'package:qrm_dev/app/modules/daftar_tkdn/controllers/daftar_tkdn_controller.dart';
import 'package:qrm_dev/app/modules/daftar_tkdn/views/create_tkdn_view.dart';
import 'package:qrm_dev/app/modules/daftar_tkdn/views/detail_daftar_tkdn_view.dart';
import 'package:qrm_dev/app/modules/daftar_tkdn/views/form_tkdn.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class DaftarTkdnView extends StatelessWidget {
  final DaftarTkdnController controller = Get.put(DaftarTkdnController());
  DaftarTkdnView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Daftar TKDN',
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => CreateTkdnView())?.then((data) {
                  if (data != null) {
                    controller.insertData(DaftarTkdn.fromJson(data));
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
                final tkdn = controller.rxDt;
                final itemWidth = MediaQuery.of(context).size.width - 30;
                if (isLoading) {
                  return Center(child: CustomLoading());
                }
                if (tkdn.isEmpty) {
                  return Empty(
                    message: 'Tidak ada data.',
                    onTap: () => controller.getTkdn(),
                  );
                }
                return LzListView(
                    padding: Ei.sym(v: 20),
                    onRefresh: () => controller.getTkdn(),
                    onScroll: (scroll) {
                      if (scroll.atBottom(100)) {
                        controller.onPaginate();
                      }
                    },
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: tkdn.map((data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final result = await Get.dialog(
                                      DetailDaftarTkdnView(data: data));
                                  if (result != null) {
                                    controller.updateData(
                                        DaftarTkdn.fromJson(result), data.id!);
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
                                        ),
                                      ),
                                      iosBlurActionGroup(
                                        onEdit: () {
                                          Get.to(() => FormTkdn(data: data))
                                              ?.then((value) {
                                            if (value != null) {
                                              controller.updateData(
                                                DaftarTkdn.fromJson(value),
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
                                              controller.deletetdkn(data.id!);
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
