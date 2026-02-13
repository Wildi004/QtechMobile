import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tidak.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/karyawan_tidak_tetap_controller/cetak_karyawan_tidak_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/karyawan_tidak_tetap_controller/karyawan_tidak_tetap_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/karyawan_tidak_tetap/create_karyawan_tidak_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/karyawan_tidak_tetap/setting_karyawan_tidak_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class KaryawanTidakView extends StatelessWidget {
  final KaryawanTidakTetapController controller =
      Get.put(KaryawanTidakTetapController());

  KaryawanTidakView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar(
        title: 'Karyawan Tidak Tetap',
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => CreateKaryawanTidakView())?.then((data) {
                  if (data != null) {
                    controller.insertData(KaryawanTidak.fromJson(data));
                  }
                });
              },
              icon: (Icon(
                Hi.add01,
                color: Colors.white,
              ))),
          IconButton(
            icon: Icon(Hi.pdf01),
            onPressed: () {
              final controller = Get.put(CetakKaryawanTidakController());
              controller.showStatusDialog();
            },
          )
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
                      onSubmitted: controller.updateSearchQuery,
                      controller: controller.searchC,
                      hint: 'Search...'),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: Obx(() {
                bool isLoading = controller.isLoading.value;
                final data = controller.listkaryawan;
                final itemWidth = MediaQuery.of(context).size.width - 30;

                if (isLoading) {
                  return Center(child: CustomLoading());
                }
                if (data.isEmpty) {
                  return Empty(
                    message: 'Tidak ada data apa pun.data ini tidak ',
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
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 60),
                                  child: Material(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(15),
                                    child: CustomScalaContainer(
                                      child: Touch(
                                        onTap: () {
                                          Get.to(
                                            () => SettingKaryawanTidakView(
                                                data: data),
                                          );
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                          width: itemWidth,
                                          padding: const EdgeInsets.all(10),
                                          decoration:
                                              CustomDecoration.validator(),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  data.name ?? 'tidak ada',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                LzImage(
                                  data.foto,
                                  size: 50,
                                  previewable: true,
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      }).toList(),
                    ),
                    Obx(() =>
                        CustomLoading().lz.hide(!controller.isPaginate.value))
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

//  onTap: () {
//                                         Get.to(() => SettingKaryawanTidakView(
//                                             data: data))?.then((value) {
//                                           if (value != null) {
//                                             controller.updateData(
//                                                 KaryawanTidak.fromJson(value),
//                                                 data.id!);
//                                           }
//                                         });
