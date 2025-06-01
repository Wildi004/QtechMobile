import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrm/app/modules/kasbon/controllers/kasbon_controller.dart';

class ModelKasbon extends StatelessWidget {
  final KasbonController controller = Get.find();

  ModelKasbon({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.kasbonList.length,
        itemBuilder: (context, index) {
          final kasbon = controller.kasbonList[index];
          return ListTile(
            title: Text(kasbon.tanggal),
            subtitle: Text(kasbon.keterangan),
            trailing: Text(kasbon.status),
          );
        },
      ),
    );
  }
}
