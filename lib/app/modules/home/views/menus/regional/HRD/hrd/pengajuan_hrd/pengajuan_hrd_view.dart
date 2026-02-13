import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/pengajuan%20global/pengajuan%20sudah%20validasi/pengajuan_sudah_validasi/pengajuan_sudah_validasi.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_pengajuan_controller/pengajuan_hrd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/pengajuan_hrd/belum_validasi_pengajuan_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/pengajuan_hrd/pengajuan_sudah_validasi_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';

import 'form_pengajuan_hrd_view.dart';

class PengajuanHrdView extends GetView<PengajuanHrdController> {
  const PengajuanHrdView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PengajuanHrdController());

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Pengajuan',
        actions: [
          CustomScalaContainer(
            child: IconButton(
              onPressed: () async {
                Get.to(() => FormPengajuanHrdView())?.then((data) {
                  if (data != null) {
                    controller
                        .insertData(PengajuanSudahValidasi.fromJson(data));
                  }
                });
              },
              icon: Icon(Hi.add01),
              color: Colors.white,
            ),
          )
        ],
      ).appBar,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Obx(() {
              int tab = controller.tab.value;
              double width = (Get.width - 56) / 2;

              return Stack(
                alignment: Ad.center,
                children: [
                  Intrinsic(
                    children: ['Belum Validasi', 'Sudah Validasi']
                        .generate((label, i) {
                      return InkTouch(
                        onTap: () {
                          controller.tab.value = i;
                        },
                        padding: Ei.sym(v: 5, h: 5),
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
                return BelumValidasiPengajuanView();
              } else {
                return PengajuanSudahValidasiView();
              }
            }),
          ),
        ],
      ),
    );
  }
}
