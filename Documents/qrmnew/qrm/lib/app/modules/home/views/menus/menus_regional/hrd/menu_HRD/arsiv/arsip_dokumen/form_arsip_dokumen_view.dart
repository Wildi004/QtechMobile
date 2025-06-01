import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/dokumen_hrd.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_arsip_dokumen_controller/form_arsip_dokumen_hrd_controller.dart';
import 'package:qrm/app/widgets/image_picker.dart';

class FormArsipDokumenView extends GetView<FormArsipDokumenHrdController> {
  final DokumenHrd? data;
  const FormArsipDokumenView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormArsipDokumenHrdController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Form Arsip Lamaran",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 91, 122),
      ),
      body: LzListView(
        gap: 25,
        children: [
          LzForm.input(
              hint: 'Inputkan nama ', label: 'Nama ', model: forms.key('nama')),
          LzForm.input(
              hint: 'Pilih Gambar',
              label: 'Pilih gambar ',
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
          LzForm.input(
              maxLines: 10,
              hint: 'keterangan ',
              label: 'keterangan ',
              model: forms.key('keterangan')),
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
