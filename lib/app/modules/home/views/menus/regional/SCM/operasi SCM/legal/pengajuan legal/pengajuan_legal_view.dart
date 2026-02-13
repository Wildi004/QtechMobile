import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20legal/pengajuan_legal/pengajuan_legal.dart';
import 'package:qrm_dev/app/modules/home/controllers/LEGAL/Pengajuan%20Legal/pengajuan_legal_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/pengajuan%20legal/create_pengajuan_legal_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/pengajuan%20legal/pengajuan_legal_belum_validasi_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/pengajuan%20legal/pengajuan_legal_sudah_validasi_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';

class PengajuanLegalView extends GetView<PengajuanLegalController> {
  const PengajuanLegalView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PengajuanLegalController());

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Pengajuan',
        actions: [
          CustomScalaContainer(
            child: IconButton(
              onPressed: () async {
                Get.to(() => CreatePengajuanLegalView())?.then((data) {
                  if (data != null) {
                    controller.insertData(PengajuanLegal.fromJson(data));
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
                return PengajuanLegalBelumValidasiView();
              } else {
                return PengajuanLegalSudahValidasiView();
              }
            }),
          ),
        ],
      ),
    );
  }
}
