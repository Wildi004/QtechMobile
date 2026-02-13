import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/capaian_kerja1/capaian_kerja1.dart';
import 'package:qrm_dev/app/modules/capaian_kinerja/controllers/capaian%20kinerja1/detail_capaian_controller.dart';
import 'package:qrm_dev/app/modules/capaian_kinerja/views/capaian_kerja1/tab%20capaian/onprogres_view.dart';
import 'package:qrm_dev/app/modules/capaian_kinerja/views/capaian_kerja1/tab%20capaian/tercapai_view.dart';
import 'package:qrm_dev/app/modules/capaian_kinerja/views/capaian_kerja1/tab%20capaian/total_laporan_kerja_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class DetailCapaian1View extends GetView<DetailCapaian1Controller> {
  final Capaian1 data;

  const DetailCapaian1View({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Get.put(DetailCapaian1Controller(data));

    double percentage = (data.selesai ?? 0) / (data.total ?? 1) * 100;

    String motivation;
    if (percentage >= 80) {
      motivation =
          'KEREN!👍, Tetap jaga performa kerja kamu\nKalau bisa lebih ditingkatkan lagi ya warga QINAR';
    } else if (percentage >= 50) {
      motivation = 'Tingkatkan lagi, ayo semangat!';
    } else {
      motivation = 'Tingkatkan ya!! 😡';
    }

    return Scaffold(
      appBar: CustomAppbar(title: 'Capaian Kinerja').appBar,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      value: percentage / 100,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation(Colors.green),
                    ),
                  ),
                  Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Motivation
            Text(
              motivation,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Tab view
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color.fromARGB(255, 173, 155, 38)
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

            const SizedBox(height: 10),

            // Konten dinamis tab
            Expanded(
              child: Obx(() {
                if (controller.tabIndex.value == 0) {
                  return TotalLaporanKerjaView(data: data);
                } else if (controller.tabIndex.value == 1) {
                  return TercapaiView(
                    data: data,
                  );
                } else if (controller.tabIndex.value == 2) {
                  return OnprogresView(
                    data: data,
                  );
                }
                return const SizedBox();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
