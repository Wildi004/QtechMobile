import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/kasbon_dep_bsd/kasbon_dep_bsd.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Kasbon%20Dev%20Bsd/kasbon_dep_bsd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/kasbon%20dep%20bsd/create_kasbon_bsd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/kasbon%20dep%20bsd/kasbon_dep_bsd_belum.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/kasbon%20dep%20bsd/kasbon_dep_bsd_val.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';

class KasbonDepBsdView extends GetView<KasbonDepBsdController> {
  const KasbonDepBsdView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => KasbonDepBsdController());

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Kasbon BSD',
        actions: [
          CustomScalaContainer(
            child: IconButton(
              onPressed: () async {
                Get.to(() => CreateKasbonBsdView())?.then((data) {
                  if (data != null) {
                    controller.insertData(KasbonDepBsd.fromJson(data));
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
                return KasbonDepBsdBelum();
              } else {
                return KasbonDepBsdVal();
              }
            }),
          ),
        ],
      ),
    );
  }
}
