import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:qrm/app/modules/capaian_kinerja/controllers/capaian_kinerja_controller.dart';
import 'package:qrm/app/modules/capaian_kinerja/views/capaian_kinerja/tercapai_view.dart';
import 'package:qrm/app/modules/capaian_kinerja/views/capaian_kinerja/total_laporan_kerja_view.dart';

class CapaianKinerjaView extends StatelessWidget {
  final CapaianKinerjaController controller =
      Get.put(CapaianKinerjaController());

  CapaianKinerjaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Capaian kinerja',
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
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04, vertical: 50),
        child: Column(
          children: [
            CircularPercentIndicator(
              radius: 70.0,
              lineWidth: 10.0,
              percent: 0.75,
              center: const Text(
                "75%",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              progressColor: Colors.green,
              backgroundColor: Colors.grey.shade300,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(
              "KEREN!, Tetap jaga performa kerja kamu\n"
              "Kalau bisa lebih ditingkatkan lagi ya Sobat QINAR",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.035),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
            Obx(() {
              int active = controller.tabIndex.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: LzTabView(
                      tabs: const [
                        'Total Laporan Kerja',
                        'Tercapai',
                        'On Progres',
                      ],
                      onTap: (key, i) {
                        controller.tabIndex.value = i;
                      },
                      builder: (label, i) {
                        bool isActive = active == i;
                        return Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: isActive
                                ? Color.fromARGB(255, 173, 155, 38)
                                : const Color.fromARGB(255, 243, 238, 238),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black),
                          ),
                          margin: EdgeInsets.only(left: i == 0 ? 0 : 8),
                          child: Text(
                            label,
                            style: TextStyle(
                              color: isActive ? Colors.white : Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 20),
            Obx(() {
              if (controller.tabIndex.value == 0) {
                return (TotalLaporanKerjaView());
              } else if (controller.tabIndex.value == 1) {
                return TercapaiView();
              }
              return SizedBox();
            })
          ],
        ),
      ),
    );
  }
}
