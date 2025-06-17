import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/models/shift_building/building.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_absen_controller/building/building_hrd_controller.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/absensi/building/detail_hrd_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/absensi/building/form_hrd_view.dart';

class BuildingHrdView extends GetView<BuildingHrdController> {
  const BuildingHrdView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BuildingHrdController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        bool isLoading = controller.isLoading.value;
        final data = controller.listBuilding;

        if (isLoading) {
          return Center(child: LzLoader.bar());
        }

        if (data.isEmpty) {
          return Empty(
            message: 'Tidak ada data apa pun.',
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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: controller.updateSearchQuery,
                    decoration: InputDecoration(
                      hintText: "Cari...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                LzButton(
                  icon: Hi.addSquare,
                  onTap: () {
                    Get.dialog(
                      FormHrdView(),
                      barrierDismissible: true,
                    ).then((data) {
                      if (data != null) {
                        controller.insertData(Building.fromJson(data));
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            ...data.generate((item, i) {
              return Touch(
                onTap: () {
                  context.openBottomSheet(DetailHrdView(
                    data: item,
                  ));
                },
                margin: Ei.only(b: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: itemWidth,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 54, 145, 220),
                        const Color.fromARGB(255, 73, 173, 255),
                        const Color.fromARGB(255, 14, 63, 210)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name ?? 'tidak ada',
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
                                  return FormHrdView(data: item);
                                },
                              ).then((value) {
                                if (value != null) {
                                  controller.updateData(
                                      Building.fromJson(value),
                                      item.buildingId!);
                                }
                              });
                            },
                            icon: Icon(Hi.edit01, color: Colors.white),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Get.defaultDialog(
                                title: 'Konfirmasi',
                                titleStyle: TextStyle(fontWeight: Fw.bold),
                                middleText:
                                    'Apakah Anda yakin ingin menghapus data ini?',
                                middleTextStyle: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018,
                                ),
                                textConfirm: 'Ya',
                                buttonColor: Colors.blue,
                                textCancel: 'Batal',
                                confirmTextColor: Colors.white,
                                onConfirm: () {
                                  Get.back();
                                  controller.delete(item.buildingId!);
                                },
                              );
                            },
                            icon: Icon(Hi.delete02, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),

            // Loader saat paginate
            Obx(() => LzLoader.bar().lz.hide(!controller.isPaginate.value)),
          ],
        );
      }),
    );
  }
}
