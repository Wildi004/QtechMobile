import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/surat_direksi.dart';
import 'package:qrm/app/modules/surat_direksi/controllers/edit_sk_controller.dart';
import 'package:qrm/app/widgets/image_picker.dart';

class EditSkView extends GetView<EditSkController> {
  final SuratDireksi? data;
  const EditSkView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EditSkController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit SK Direksi",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 91, 122),
      ),
      body: LzListView(
        gap: 25,
        children: [
          LzForm.input(
              hint: 'Pilih Gambar',
              label: 'Pilih gambar tkdn',
              model: forms.key('image'),
              suffixIcon: Hi.image01,
              onTap: () {
                Pickers.image(then: (file) {
                  if (file != null) {
                    forms.set('image', file.path);
                    controller.fileName.value = file.path;
                    controller.file = File(file.path);
                  }
                });
              }),
          Obx(() => controller.fileName.value.isEmpty
              ? const None()
              : Column(
                  children: [
                    LzImage(controller.file, size: 100),
                  ],
                ).start)
        ],
      ),
      bottomNavigationBar: LzButton(
        text: data == null ? 'Submit' : 'Update',
        onTap: () {
          controller.onSubmit(data?.id);
        },
      ).margin(all: 20),
    );
  }
}
