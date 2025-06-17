import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_pengajuan_controller/create_pengajuan_hrd_controller.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/pengajuan_hrd/belum_validasi_pengajuan_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/pengajuan_hrd/pengajuan_sudah_validasi_view.dart';

import 'form_pengajuan_hrd_view.dart';

class PengajuanHrdView extends GetView<CreatePengajuanHrdController> {
  const PengajuanHrdView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreatePengajuanHrdController());

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              // ...
              // open page
              Get.to(() => FormPengajuanHrdView());

              // await controller.createPengajuan();
              // if (controller.pengajuanId.value != 0) {
              //   Get.to(() => CreatePengajuanHrdView());
              // } else {
              //   Get.snackbar('Gagal', 'Gagal membuat data pengajuan');
              // }
            },
            icon: Icon(Hi.add01),
            color: Colors.white,
          )
        ],
        centerTitle: true,
        title: Text(
          'Pengajuan Dana',
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

          /// Gantilah ini menjadi Expanded agar LzListView di dalam KreditView bisa scroll
          Expanded(
            child: Obx(() {
              if (controller.tab.value == 0) {
                return PengajuanSudahValidasiView();
              } else {
                return BelumValidasiPengajuanView();
              }
            }),
          ),
        ],
      ),
    );
  }
}
