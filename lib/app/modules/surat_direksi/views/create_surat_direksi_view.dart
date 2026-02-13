import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/surat_direksi.dart';
import 'package:qrm_dev/app/modules/surat_direksi/controllers/create_sk_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/image_picker.dart';

class CreateSuratDireksiView extends GetView<CreateSkController> {
  final SuratDireksi? data;
  const CreateSuratDireksiView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateSkController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Buat SK Direksi',
        actions: [
          IconButton(
              onPressed: () {
                controller.onSubmit(data?.id);
              },
              icon: Icon(Hi.tick03))
        ],
      ).appBar,
      body: LzListView(
        gap: 15,
        children: [
          LzForm.input(
              hint: 'Inputkan nama SK Direksi',
              label: 'Nama SK Direksi',
              model: forms.key('nama')),
          LzForm.input(
              hint: 'Inputkan tanggal',
              label: 'Tanggal Sk',
              model: forms.key('tgl_sk'),
              suffixIcon: Hi.calendar02,
              onTap: () {
                LzPicker.date(context, initDate: forms.get('tgl_sk').toDate(),
                    onSelect: (date) {
                  forms.set('tgl_sk', date.format());
                });
              }),
          LzForm.input(
              hint: 'Pilih Gambar',
              label: 'Pilih gambar SK Direksi',
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
                ).start),
          LzForm.input(
            hint: 'No SK',
            label: 'No SK',
            model: forms.key('no_sk'),
          ),
        ],
      ),
    );
  }
}
