import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrm_dev/app/modules/absence/controllers/absence_controller.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';

class CardInfoAbsen extends StatelessWidget {
  final AbsenceController controller = Get.find();
  CardInfoAbsen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final totalTelat = controller.countLate(controller.rawAbsensi);
      final bulan = controller.absensiData.isNotEmpty
          ? controller.absensiData.first['bulan']
          : '-';
      final totalMenit = controller.totalLateMinutesByMonth(bulan);
      return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.023),
        decoration: CustomDecoration.main2(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jumlah Telat Bulan :',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$totalTelat x (Hari)',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  bulan,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$totalMenit Menit (Total)',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
