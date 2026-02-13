import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrm_dev/app/modules/absence/controllers/absence_controller.dart';

class AllInfoAbsen extends GetView<AbsenceController> {
  AllInfoAbsen({super.key});

  final RxMap<String, bool> showDetails = <String, bool>{}.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.absensiData.isEmpty) {
        return const Text('Tidak ada data absensi');
      }
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: SingleChildScrollView(
            child: Column(
              children: controller.absensiData.map((absensi) {
                final String bulan = absensi["bulan"];
                final bool isExpanded = showDetails[bulan] ?? false;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDetails[bulan] = !isExpanded;
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              bulan,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            AnimatedRotation(
                              turns: isExpanded ? 0.5 : 0.0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: MediaQuery.of(context).size.height * 0.03,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.fastOutSlowIn,
                      child: isExpanded
                          ? Container(
                              margin: const EdgeInsets.only(top: 5),
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Column(
                                children: absensi["data"].map<Widget>((absen) {
                                  return InkWell(
                                    onTap: () {
                                      controller.showDetailDialog(absen);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            absen['tanggal'],
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.017,
                                              color: absen['status']
                                                          .toString()
                                                          .toLowerCase() ==
                                                      'sakit'
                                                  ? Colors.orange
                                                  : absen['status']
                                                              .toString()
                                                              .toLowerCase() ==
                                                          'cuti'
                                                      ? Colors.blue
                                                      : absen['isLate'] == true
                                                          ? Colors.red
                                                          : Colors.green,
                                            ),
                                          ),
                                          Text(
                                            absen['status'],
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.017,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          : const SizedBox(),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      );
    });
  }
}
