// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/monitoring_proyek/controllers/monitoring_proyek_controller.dart';
import 'package:qrm/app/modules/reg_pusat/views/hasil_perhitungan_view.dart';
import 'package:qrm/app/modules/reg_pusat/views/informasi_umum_view.dart';

class RegPusatView extends GetView<MonitoringProyekController> {
  const RegPusatView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MonitoringProyekController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'MONITORING PROYEK',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[800],
      ),
      body: Column(
        mainAxisSize: Mas.min,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.09,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Colors.blue[800],
            ),
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width * 0.04,
            ),
            width: double.infinity,
            child: Column(
              mainAxisSize: Mas.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'QRM 401/K-P',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.055,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: LzListView(
              children: [
                Obx(() {
                  int tab = controller.tab.value;
                  double width = (Get.width - 56) / 2;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Intrinsic(
                        children: ['Informasi Umum', 'Hasil Perhitungan']
                            .generate((label, i) {
                          return InkTouch(
                            onTap: () {
                              controller.tab.value = i;
                            },
                            padding: Ei.sym(v: 13, h: 15),
                            color: Colors.white,
                            child: Text(label,
                                textAlign: TextAlign.center,
                                style: Gfont.fbold(tab == i)),
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
                            color: Colors.orange.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      )
                    ],
                  )
                      .lz
                      .clip(all: 7)
                      .lz
                      .border(Border.all(), radius: Br.radius(7));
                }),
                Obx(() {
                  int tab = controller.tab.value;

                  return IndexedStack(
                    index: tab,
                    children: [
                      InformasiUmumView(),
                      const HasilPerhitunganView()
                    ],
                  );
                }),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(() {
                    int profile = controller.showProfile.value;
                    bool isClosed = profile == -1;

                    return SizedBox(
                      width: Get.width,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: ['Wildi', 'Hendi', 'Toni']
                            .asMap()
                            .entries
                            .map((entry) {
                          int i = entry.key;
                          String name = entry.value;

                          return Touch(
                            onTap: () {
                              if (profile == i) {
                                controller.showProfile.value = -1;
                              } else {
                                controller.showProfile.value = i;
                              }
                            },
                            child: AnimatedContainer(
                              duration: 250.ms,
                              curve: Curves.easeInOut,
                              child: Row(
                                children: [
                                  LzAvatar(size: 40),
                                  if (profile == i)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(name),
                                        Text('${name.toLowerCase()}@gmail.com'),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ).gap(isClosed ? 0 : 10).center,
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
