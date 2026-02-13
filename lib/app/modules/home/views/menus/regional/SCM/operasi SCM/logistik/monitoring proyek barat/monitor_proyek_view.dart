import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Monitoring%20Material%20Proyek%20Barat/monitor_proyek_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/monitoring%20proyek%20barat/monitor_proyek_barat_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/monitoring%20proyek%20timur/monitor_proyek_timur_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';

class MonitorProyekView extends GetView<MonitorProyekController> {
  const MonitorProyekView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MonitorProyekController());

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Monitoring Material Proyek',
        actions: [
          CustomScalaContainer(
            child: IconButton(
              onPressed: () async {
                // Get.to(() => CreatePengajuanLogistikView())?.then((data) {
                //   if (data != null) {
                //     controller.insertData(PengajuanLogistik.fromJson(data));
                //   }
                // });
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
                    children:
                        ['Proyek Barat', 'Proyek Timur'].generate((label, i) {
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
                return MonitorProyekBaratView();
              } else {
                return MonitorProyekTimurView();
              }
            }),
          ),
        ],
      ),
    );
  }
}
