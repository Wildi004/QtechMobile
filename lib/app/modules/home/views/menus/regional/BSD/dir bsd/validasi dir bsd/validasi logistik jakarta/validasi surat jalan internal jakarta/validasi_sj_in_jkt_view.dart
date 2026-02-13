import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Surat%20Jalan%20Logistik%20Jkt/surat%20jalan%20internal%20jkt/surat_jalan_internal_jkt_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20jakarta/validasi%20surat%20jalan%20internal%20jakarta/validasi_sj_in_jkt_belum_val_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20jakarta/validasi%20surat%20jalan%20internal%20jakarta/validasi_sj_in_jkt_sudah_val_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class ValidasiSjInJktView extends GetView<SuratJalanInternalJktController> {
  const ValidasiSjInJktView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SuratJalanInternalJktController());
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Get.back(result: true);
        }
      },
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Validasi surat jalan eksternal Jakarta',
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
                  return ValidasiSjInJktBelumValView();
                } else {
                  return ValidasiSjInJktSudahValView();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
