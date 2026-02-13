import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrm_dev/app/modules/settings/controllers/settings_controller.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';

class CutiProfileSettingView extends StatelessWidget {
  final SettingsController controller = Get.find();
  CutiProfileSettingView({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        width: screenWidth * 0.9,
        decoration: BoxDecoration(
          color: const Color.fromARGB(0, 131, 15, 15),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [],
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Container(
            width: screenWidth * 0.9,
            padding: const EdgeInsets.all(15),
            decoration: CustomDecoration.main2(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: Text(
                    'Februari - 2025',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.025,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Obx(() {
                  final cuti = controller.cuti.value;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CutiProfileSettingView1.build(
                        "${cuti?.jmlCuti ?? '0'}",
                        "Hari",
                        "Cuti",
                        context,
                      ),
                      CutiProfileSettingView1.build(
                          "6", "Hari", "Izin", context),
                      CutiProfileSettingView1.build(
                          "1000", "Menit", "Telat", context),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CutiProfileSettingView1 {
  static Widget build(
    String number,
    String unit,
    String label,
    BuildContext context,
  ) {
    double fontSizes = MediaQuery.of(context).size.width * 0.05;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
      ),
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: number,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSizes,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: " $unit",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
