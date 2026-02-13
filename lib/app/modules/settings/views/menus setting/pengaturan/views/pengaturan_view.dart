import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import '../controllers/pengaturan_controller.dart';

class PengaturanView extends GetView<PengaturanController> {
  const PengaturanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Pengaturan'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                controller.isDarkMode.value ? Hi.sun02 : Hi.moon02,
              ),
              onPressed: () {
                controller.toggleDarkMode(!controller.isDarkMode.value);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CustomLoading(),
        ),
      );
    });
  }
}
