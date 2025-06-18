import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrm/app/modules/capaian_kinerja/controllers/capaian_kinerja_controller.dart';

class SplashScreenView extends StatelessWidget {
  final CapaianKinerjaController controller =
      Get.put(CapaianKinerjaController());
  SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Container(
        height: 200,
        width: 200,
        color: Colors.blue,
        child: Obx(() {
          final cap = controller.cap2.value;
          return Text(cap.gagal?.toString() ?? 'o');
        }),
      ),
    );
  }
}
