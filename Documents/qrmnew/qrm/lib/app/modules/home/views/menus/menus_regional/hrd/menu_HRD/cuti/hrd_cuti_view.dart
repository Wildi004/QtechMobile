import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_cuti_sudah_validasi_controller/hrd_cuti_sudah_validasi_controller.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/cuti/belum_validasi_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/cuti/sudah_validasi_view.dart';

class HrdCutiView extends GetView<HrdCutiSudahValidasiController> {
  const HrdCutiView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HrdCutiSudahValidasiController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cuti',
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
      body: Column(
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
                    children: ['Sudah Validasi', 'Belum Validasi']
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

          10.height,

          Expanded(
            child: Obx(() {
              if (controller.tab.value == 0) {
                return SudahValidasiView();
              } else {
                return BelumValidasiView();
              }
            }),
          ),
        ],
      ),
    );
  }
}
