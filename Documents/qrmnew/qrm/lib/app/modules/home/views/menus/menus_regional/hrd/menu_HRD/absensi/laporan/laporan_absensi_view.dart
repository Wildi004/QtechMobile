import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_absen_controller/laporan_absensi/laporan_absensi_controller.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/absensi/laporan/perkaryawan_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/absensi/laporan/seluruh_karyawan_view.dart';

class LaporanAbsensiView extends GetView<LaporanAbsensiController> {
  const LaporanAbsensiView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LaporanAbsensiController());

    return Scaffold(
      body: LzListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          // Tab bar
          Padding(
            padding: const EdgeInsets.all(10),
            child: Obx(() {
              int tab = controller.tab.value;
              double width = (Get.width - 56) / 2;

              return Stack(
                alignment: Ad.center,
                children: [
                  Intrinsic(
                    children: ['Seluruh Karyawan', 'Per Karyawan']
                        .generate((label, i) {
                      return InkTouch(
                        onTap: () {
                          controller.tab.value = i;
                        },
                        padding: Ei.sym(v: 5, h: 5),
                        color: Colors.white,
                        child: Text(
                          label,
                          textAlign: Ta.center,
                          style: Gfont.fbold(tab == i),
                        ),
                      );
                    }),
                  ),
                  AnimatedPositioned(
                    duration: 250.ms,
                    left: tab == 0 ? (width * tab) + 4 : (width * tab) + 11,
                    child: Container(
                      width: width,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.orange.applyOpacity(.3),
                        borderRadius: Br.radius(5),
                      ),
                    ),
                  ),
                ],
              ).lz.clip(all: 7).lz.border(Br.all(), radius: Br.radius(7));
            }),
          ),

          30.height,

          // Konten berdasarkan tab, panggil widget yang terpisah
          Obx(() {
            if (controller.tab.value == 0) {
              return FilterAbsensiView();
            } else {
              return PerkaryawanView();
            }
          }),

          100.height,
        ],
      ),
    );
  }
}
