import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/daftar_tkdn.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_arsip_controller/create_arsip_karyawan_controller.dart';
import 'package:qrm/app/widgets/image_picker.dart';

class CreateArsipKaryawanView extends GetView<CreateArsipKaryawanController> {
  final DaftarTkdn? data;
  const CreateArsipKaryawanView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateArsipKaryawanController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Buat ",
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
              model: forms.key('files[]'),
              suffixIcon: Hi.image01,
              onTap: () {
                Pickers.image(then: (file) {
                  if (file != null) {
                    forms.set('files[]', file.path);
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
