import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/cuti.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_setting_controller/setting_cuti/setting_cuti_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/setting/cuti_hrd/create_cuti_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/setting/cuti_hrd/update_cuti_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class CutiHrdView extends GetView<SettingCutiController> {
  const CutiHrdView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;
    Get.lazyPut(() => SettingCutiController());
    return Obx(() {
      bool isLoading = controller.isLoading.value;
      final cuti = controller.listcuti;

      if (isLoading) {
        return Center(child: CustomLoading());
      }

      if (cuti.isEmpty) {
        return Empty(
          message: 'Tidak ada data apa pun.',
          onTap: () => controller.getData(),
        );
      }

      return Column(
        children: [
          Padding(
            padding: Ei.sym(v: 20),
            child: Row(
              children: [
                Expanded(
                  child: SearchQuery.searchInput(
                      onSubmitted: controller.updateSearchQuery,
                      controller: controller.searchC,
                      hint: 'Search...'),
                ),
                SizedBox(width: 10),
                CustomScalaContainer(
                  child: LzButton(
                      icon: Hi.addSquare,
                      onTap: () {
                        Get.dialog(
                          CreateCutiHrdView(),
                          barrierDismissible: true,
                        ).then((data) {
                          if (data != null) {
                            controller.insertData(Cuti.fromJson(data));
                          }
                        });
                      }),
                )
              ],
            ),
          ),
          Expanded(
            child: LzListView(
              padding: Ei.sym(v: 0),
              onRefresh: () => controller.getData(),
              onScroll: (scroll) {
                if (scroll.atBottom(100)) {
                  controller.onPaginate();
                }
              },
              children: [
                ...cuti.generate((item, i) {
                  return CustomScalaContainer(
                    child: Touch(
                      margin: Ei.only(b: 10),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: itemWidth,
                        padding: const EdgeInsets.all(10),
                        decoration: CustomDecoration.validator(),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.user ?? 'tidak ada',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return UpdateCutiView(data: item);
                                      },
                                    ).then((value) {
                                      if (value != null) {
                                        controller.updateData(
                                            Cuti.fromJson(value), item.id!);
                                      }
                                    });
                                  },
                                  icon: Icon(Hi.edit01, color: Colors.white),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    CustomDelete.show(
                                      title: 'Konfirmasi Hapus',
                                      message:
                                          'Apakah Anda Yakin Ingin Menghapus Data Ini?',
                                      context: context,
                                      onConfirm: () {
                                        controller.delete(item.id!);
                                      },
                                    );
                                  },
                                  icon: Icon(Hi.delete02, color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                Obx(() => CustomLoading().lz.hide(!controller.isPaginate.value))
              ],
            ),
          ),
        ],
      );
    });
  }
}
