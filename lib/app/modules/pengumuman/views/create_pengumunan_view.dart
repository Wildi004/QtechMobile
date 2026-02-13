import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';

import 'package:qrm_dev/app/data/models/pengumuman.dart';
import 'package:qrm_dev/app/modules/pengumuman/controllers/create_pengumuman_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/image_picker.dart';

class CreatePengumunanView extends GetView<CreatePengumumanController> {
  final Pengumuman? data;
  const CreatePengumunanView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreatePengumumanController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Buat Pengumuman',
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
              hint: 'Masukan Judul', label: 'Judul', model: forms.key('judul')),
          LzForm.input(
              hint: 'Inputkan tanggal',
              label: 'Tanggal Expired',
              model: forms.key('tgl_expired'),
              suffixIcon: Hi.calendar02,
              onTap: () {
                LzPicker.date(
                  context,
                  initDate: forms.get('tgl_expired').toDate(),
                  onSelect: (date) {
                    final formatted = '${date.format('yyyy-MM-dd')} 00:00:00';
                    forms.set('tgl_expired', formatted);
                  },
                );
              }),
          LzForm.input(
              hint: 'Pilih Gambar',
              label: 'Pilih gambar Brosur Logistik',
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
        ],
      ),
    );
  }
}
