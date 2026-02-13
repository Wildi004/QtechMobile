import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/PTJ%20Logistik/ptj_logistik_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/ptj%20logistik/ptj_logistik_belum_validasi_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/ptj%20logistik/ptj_logistik_sudah_validasi_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/ptj%20logistik/show_regional_logistik.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class PtjLogistikView extends GetView<PtjLogistikController> {
  final String type;

  const PtjLogistikView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PtjLogistikController());

    return Scaffold(
      appBar: CustomAppbar(
        title: 'PTJ Logistik',
        actions: [
          IconButton(
            onPressed: () {
              ShowRegionalLogistik.showRegLogistik(context);
            },
            icon: const Icon(Hi.add01),
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
          Expanded(
            child: Obx(() {
              if (controller.tab.value == 0) {
                return PtjLogistikBelumValidasiView();
              } else {
                return PtjLogistikSudahValidasiView();
              }
            }),
          ),
        ],
      ),
    );
  }
}
