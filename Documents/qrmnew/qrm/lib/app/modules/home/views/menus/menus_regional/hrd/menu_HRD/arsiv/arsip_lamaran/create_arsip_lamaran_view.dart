import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/arsip_lamaran.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_arsip_lamaran_controller/create_arsip_lamaran_controller.dart';
import 'package:qrm/app/widgets/image_picker.dart';

class CreateArsipLamaranView extends GetView<CreateArsipLamaranController> {
  final ArsipLamaran? data;
  const CreateArsipLamaranView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateArsipLamaranController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
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
              hint: 'Inputkan tanggal',
              label: 'Tanggal Lamaran',
              model: forms.key('tgl_lamaran'),
              suffixIcon: Hi.calendar02,
              onTap: () {
                LzPicker.date(context,
                    initDate: forms.get('tgl_lamaran').toDate(),
                    onSelect: (date) {
                  forms.set('tgl_lamaran', date.format());
                });
              }),
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
              hint: 'Posisi yang dilamar',
              label: 'posisi yang dilamar ',
              model: forms.key('posisi')),
          LzForm.input(
              hint: 'Lokasi Penempetan ',
              label: 'Lokasi Penempetan ',
              model: forms.key('lokasi_kantor')),
          LzForm.select(
            label: 'Status',
            hint: 'Pilih Status',
            model: controller.forms.key('status'),
            onTap: () async {
              final data = await controller.getStatus().overlay();
              controller.forms.set('status').options(data.labelValue(
                    'name',
                  ));
            },
          ),
          Obx(() => controller.fileName.value.isEmpty
              ? const None()
              : Column(
                  children: [
                    LzImage(controller.file, size: 100),
                  ],
                ).start),
          LzButton(
            text: data == null ? 'Submit' : 'Update',
            onTap: () {
              controller.onSubmit(data?.id);
            },
          ).margin(all: 30),
        ],
      ),
    );
  }
}
