import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/rab_it/rab_it.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Rab%20IT/rab_it_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/rab%20it/create_rab_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/rab%20it/rab_it_belum_validasi_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/rab%20it/rab_it_sudah_validasi_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class RabItView extends GetView<RabItController> {
  const RabItView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RabItController());

    return Scaffold(
      appBar: CustomAppbar(
        title: 'RAB IT',
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    Get.to(() => CreateRabItView())?.then((data) {
                      if (data != null) {
                        controller.insertData(RabIt.fromJson(data));
                      }
                    });
                  },
                  icon: Icon(
                    Hi.add01,
                    color: Colors.white,
                  ))),
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
                return RabItBelumValidasiView();
              } else {
                return RabItSudahValidasiView();
              }
            }),
          ),
        ],
      ),
    );
  }
}
