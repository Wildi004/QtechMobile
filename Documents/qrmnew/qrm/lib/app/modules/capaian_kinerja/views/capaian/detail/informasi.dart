import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:qrm/app/data/models/capaian/data.dart' as capaian_data;
import 'package:qrm/app/modules/capaian_kinerja/controllers/capaian_controller.dart';
import 'package:qrm/app/modules/capaian_kinerja/views/capaian/detail/total_laporan_kerja_view.dart';
import 'package:lazyui/lazyui.dart'; // pastikan LzTabView tersedia

class Informasi extends StatelessWidget {
  final capaian_data.Data data;

  Informasi({super.key, required this.data});

  final controller = Get.put(CapaianController());

  @override
  Widget build(BuildContext context) {
    final total = data.team?.fold(0, (sum, t) => sum + (t.total ?? 0)) ?? 0;
    final tercapai =
        data.team?.fold(0, (sum, t) => sum + (t.tercapai ?? 0)) ?? 0;
    final onProgress = total - tercapai;
    final percent = total == 0 ? 0.0 : tercapai / total;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Detail Capaian Kinerja',
            style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: ['4CA1AF'.hex, '808080'.hex],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircularPercentIndicator(
                radius: 80.0,
                lineWidth: 12.0,
                percent: percent.clamp(0.0, 1.0),
                center: Text('${(percent * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                progressColor: Colors.green,
                backgroundColor: Colors.grey.shade300,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'KEREN!, Tetap jaga performa kerja kamu\nKalau bisa lebih ditingkatkan lagi ya Sobat QINAR',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Column(
                children: [
                  LzTabView(
                    tabs: const [
                      'Total Laporan Kerja',
                      'Tercapai',
                      'On Progres',
                    ],
                    onTap: (key, i) {
                      controller.tabIndex.value = i;
                    },
                    builder: (label, i) {
                      return Obx(() {
                        final isActive = controller.tabIndex.value == i;
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
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  Obx(() {
                    switch (controller.tabIndex.value) {
                      case 0:
                        return TotalLaporanKerjaWidget(
                          total: total,
                          onProgress: onProgress,
                          tercapai: tercapai,
                        );
                      case 1:
                        return _infoCard(
                          "Tercapai",
                          tercapai,
                          Color.fromARGB(255, 58, 156, 93),
                        );
                      case 2:
                        return _infoCard(
                          "On Progress",
                          onProgress,
                          Color.fromARGB(255, 186, 193, 70),
                        );
                      default:
                        return const SizedBox();
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String title, int value, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          // ignore: deprecated_member_use
          colors: [color.withOpacity(0.9), color],
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 16)),
          Text(value.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
        ],
      ),
    );
  }
}
