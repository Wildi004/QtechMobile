import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/surat_internal.dart';
import 'package:qrm_dev/app/modules/surat_internal/controllers/edit_surat_internal_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/image_picker.dart';

class EditSuratInternalView extends GetView<EditSuratInternalController> {
  final SuratInternal? data;
  const EditSuratInternalView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EditSuratInternalController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (data?.image != null && data!.image!.isNotEmpty) {
        controller.fileName.value = data!.image!;
        // file tetap null karena user belum memilih file baru
      }
    });

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Edit Surat Internal',
        actions: [
          IconButton(
              onPressed: () {
                controller.onSubmit(data?.id);
              },
              icon: Icon(Hi.tick03))
        ],
      ).appBar,
      body: LzListView(
        gap: 25,
        children: [
          LzForm.input(
              hint: 'Inputkan Surat Internal',
              label: 'Surat Internal',
              model: forms.key('nama')),
          LzForm.input(
              hint: 'Inputkan tanggal',
              label: 'Tanggal Upload',
              model: forms.key('tgl_upload'),
              suffixIcon: Hi.calendar02,
              onTap: () {
                LzPicker.date(context,
                    initDate: forms.get('tgl_upload').toDate(),
                    onSelect: (date) {
                  forms.set('tgl_upload', date.format());
                });
              }),
          LzForm.input(
              hint: 'Pilih Gambar',
              label: 'Pilih gambar Surat Internal',
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
    );
  }
}
