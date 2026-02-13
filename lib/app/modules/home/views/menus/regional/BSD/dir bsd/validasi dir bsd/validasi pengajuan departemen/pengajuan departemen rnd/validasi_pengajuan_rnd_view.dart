import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/RND/Pengajuan%20RND/pengajuan_rnd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20pengajuan%20departemen/pengajuan%20departemen%20rnd/validasi_pengajuan_rnd_belum_valid_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/pengajuan%20rnd/pengajuan_rnd_sudah_validasi_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class ValidasiPengajuanRndView extends GetView<PengajuanRndController> {
  const ValidasiPengajuanRndView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PengajuanRndController());

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Get.back(result: true);
        }
      },
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Validasi Pengajuan RND',
        ).appBar,
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
                  return ValidasiPengajuanRndBelumValidView();
                } else {
                  return PengajuanRndSudahValidasiView();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
