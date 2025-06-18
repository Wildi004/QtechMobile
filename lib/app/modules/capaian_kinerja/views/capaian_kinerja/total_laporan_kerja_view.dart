import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrm/app/modules/capaian_kinerja/controllers/capaian_kinerja_controller.dart';

class TotalLaporanKerjaView extends StatelessWidget {
  final CapaianKinerjaController controller = Get.find();

  TotalLaporanKerjaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
