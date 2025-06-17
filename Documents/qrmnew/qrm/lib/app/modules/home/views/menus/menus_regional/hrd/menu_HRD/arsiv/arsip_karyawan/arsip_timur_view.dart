import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/arsip_karyawan_hrd/arsip_karyawan_hrd.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_arsip_controller/arsip_karyawan_timur_controller.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/arsiv/arsip_karyawan/arsip_karyawan_sett_view.dart';

class ArsipTimurView extends GetView<ArsipKaryawanTimurController> {
  const ArsipTimurView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ArsipKaryawanTimurController());

    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Arsip Karyawan Timur',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: ['4CA1AF'.hex, '808080'.hex],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        ),
      ),
      body: Obx(() {
        bool isLoading = controller.isLoading.value;
        final data = controller.rxAK;

        if (isLoading) {
          return Center(child: LzLoader.bar());
        }

        if (data.isEmpty) {
          return Empty(
            message: 'Tidak ada data apa pun.',
            onTap: () => controller.getArsip(),
          );
        }

        return LzListView(
          padding: Ei.sym(v: 20, h: 20),
          onRefresh: () => controller.getArsip(),
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
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // LzButton(
                //   icon: Hi.addSquare,
                //   onTap: () {},
                // ),
              ],
            ),
            const SizedBox(height: 20),

            ...data.generate((item, i) {
              return Touch(
                onTap: () {
                  Get.to(() => ArsipKaryawanSettView(data: item))
                      ?.then((value) {
                    if (value != null) {
                      controller.updateData(
                          ArsipKaryawanHrd.fromJson(value), item.userId!);
                    }
                  });
                },
                margin: Ei.only(b: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.09,
                  width: itemWidth,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 54, 145, 220),
                        Color.fromARGB(255, 73, 173, 255),
                        Color.fromARGB(255, 14, 63, 210)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name ?? 'tidak ada',
                              style: GoogleFonts.notoSerif().copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
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
                              Get.back(); // Tutup dialog
                              // controller.deletet(data
                              //     .id!); // Jalankan fungsi simpan
                            },
                          );
                        },
                        icon: Icon(Hi.delete02, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            }),

            // animasi loading paginasi
            Obx(() => LzLoader.bar().lz.hide(!controller.isPaginate.value))
          ],
        );
      }),
    );
  }
}
