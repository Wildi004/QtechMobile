import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/cuti.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_setting_controller/setting_cuti/setting_cuti_controller.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/setting/cuti_hrd/create_cuti_hrd_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/setting/cuti_hrd/update_cuti_view.dart';

class CutiHrdView extends GetView<SettingCutiController> {
  const CutiHrdView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;
    Get.lazyPut(() => SettingCutiController());
    return Obx(() {
      bool isLoading = controller.isLoading.value;
      final cuti = controller.searchQuery.value.isEmpty
          ? controller.listcuti
          : controller.cuti;

      if (isLoading) {
        return Center(child: LzLoader.bar());
      }

      if (cuti.isEmpty) {
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
          // Row Search + Button Tambah
          Row(
            children: [
              // Search Field
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
              // Button Tambah
              LzButton(
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
                  })
            ],
          ),
          SizedBox(height: 20),

          ...cuti.generate((item, i) {
            return Touch(
              onTap: () {
                // Get.to(() => DetailNotulen(
                //       judul: item.judul,
                //       isi: item.isi,
                //       sifat: item.sifat,
                //       tgl: item.tglRapat,
                //       departemen: item.departemen,
                //       jumlah: item.jmlPeserta,
                //     ));
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
                            Get.defaultDialog(
                              title: 'Konfirmasi',
                              titleStyle: TextStyle(fontWeight: Fw.bold),
                              middleText:
                                  'Apakah Anda yakin ingin menghapus data ini?',
                              middleTextStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018,
                              ),
                              textConfirm: 'Ya',
                              buttonColor: Colors.blue,
                              textCancel: 'Batal',
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                Get.back();
                                controller.delete(item.id!);
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

          Obx(() => LzLoader.bar().lz.hide(!controller.isPaginate.value))
        ],
      );
    });
  }
}
