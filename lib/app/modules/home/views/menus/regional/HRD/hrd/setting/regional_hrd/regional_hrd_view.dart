import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/regional.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_setting_controller/setting_regional/form_regional_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_setting_controller/setting_regional/setting_regional_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/setting/regional_hrd/form_regional_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_delete.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class RegionalHrdView extends GetView<SettingRegionalController> {
  const RegionalHrdView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;
    Get.lazyPut(() => SettingRegionalController());
    return Obx(() {
      bool isLoading = controller.isLoading.value;
      final reg = controller.searchQuery.value.isEmpty
          ? controller.listReg
          : controller.reg;

      if (isLoading) {
        return Center(child: CustomLoading());
      }

      if (reg.isEmpty) {
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
                        onChanged: controller.updateSearchQuery)),
                SizedBox(width: 10),
                CustomScalaContainer(
                  child: LzButton(
                    icon: Hi.addSquare,
                    onTap: () {
                      final createController =
                          Get.put(FormRegionalController());
                      createController.resetForm();
                      Get.dialog(
                        FormRegionalView(),
                        barrierDismissible: true,
                      ).then((data) {
                        if (data != null) {
                          controller.insertData(Regional.fromJson(data));
                        }
                      });
                    },
                  ),
                ),
                // ),
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
                ...reg.generate((item, i) {
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
                                item.regional ?? 'tidak ada',
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
                                        return FormRegionalView(data: item);
                                      },
                                    ).then((value) {
                                      if (value != null) {
                                        controller.updateData(
                                            Regional.fromJson(value), item.id!);
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
