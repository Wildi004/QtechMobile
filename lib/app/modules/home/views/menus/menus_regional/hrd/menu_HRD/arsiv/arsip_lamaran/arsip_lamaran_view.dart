import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/arsip_lamaran.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_arsip_lamaran_controller/arsip_lamaran_controller.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/arsiv/arsip_lamaran/create_arsip_lamaran_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/arsiv/arsip_lamaran/detail_arsip_lamaran_view.dart';

class ArsipLamaranView extends GetView<ArsipLamaranController> {
  const ArsipLamaranView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      Get.lazyPut(() => ArsipLamaranController());
      bool depLoad = controller.isLoading.value;
      final dep = controller.searchQuery.value.isEmpty
          ? controller.listArsip
          : controller.arsip;

      if (depLoad) {
        return Center(child: LzLoader.bar());
      }

      if (dep.isEmpty) {
        return Empty(
          message: 'Tidak ada data apa pun.',
          onTap: () => controller.getData(),
        );
      }

      return Expanded(
        child: LzListView(
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
                    Get.to(() => CreateArsipLamaranView())?.then((data) {
                      if (data != null) {
                        controller.insertData(ArsipLamaran.fromJson(data));
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ...dep.generate((item, i) {
              return Touch(
                onTap: () {
                  Get.to(() => DetailArsipLamaranView(data: item))
                      ?.then((value) {
                    if (value != null) {
                      controller.updateData(
                          ArsipLamaran.fromJson(value), item.id!);
                    }
                  });
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
                          item.nama ?? 'tidak ada',
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
                              Get.to(() => CreateArsipLamaranView(data: item))
                                  ?.then((value) {
                                if (value != null) {
                                  controller.updateData(
                                      ArsipLamaran.fromJson(value), item.id!);
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
        ),
      );
    });
  }
}
