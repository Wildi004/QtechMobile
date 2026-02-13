import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20legal/dok_ken_legal.dart';
import 'package:qrm_dev/app/modules/home/controllers/LEGAL/Dokumentasi%20Kendaraan%20Legal/create_dok_ken_legal_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateDokKenView extends GetView<CreateDokKenLegalController> {
  final DokKenLegal? data;
  const CreateDokKenView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateDokKenLegalController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Form Add',
        actions: [
          IconButton(
            onPressed: () {
              controller.onSubmit(data?.id);
            },
            icon: Icon(Hi.tick04),
          ),
        ],
      ).appBar,
      body: LzListView(
        gap: 20,
        children: [
          LzForm.input(
            maxLines: 99,
            hint: 'Masukkan Keterangan',
            label: 'Keterangan',
            model: forms.key('keterangan'),
          ),
          Intrinsic(
            gap: 10,
            children: [
              LzForm.input(
                hint: 'Masukkan Tanggal Pengurus',
                label: 'Tanggal Pengurus',
                model: forms.key('tgl_pengurusan'),
                suffixIcon: Hi.calendar02,
                onTap: () {
                  LzPicker.date(context,
                      minDate: DateTime(1900),
                      initDate: forms.get('tgl_pengurusan').toDate(),
                      onSelect: (date) {
                    forms.set('tgl_pengurusan', date.format());
                  });
                },
              ),
              LzForm.input(
                hint: 'Masukan Tanggal Expired',
                label: 'Tanggal Expired',
                model: forms.key('tgl_exp'),
                keyboard: TextInputType.number,
                suffixIcon: Hi.calendar02,
                onTap: () {
                  LzPicker.date(context,
                      minDate: DateTime(1900),
                      initDate: forms.get('tgl_exp').toDate(),
                      onSelect: (date) {
                    forms.set('tgl_exp', date.format());
                  });
                },
              ),
            ],
          ),
          LzForm.input(
            hint: 'Upload Foto/Gambar Aset',
            label: 'Gambar Aset',
            model: forms.key('image'),
            suffixIcon: Hi.image01,
            readOnly: true,
            onTap: () async {
              final picker = ImagePicker();

              final source = await Get.dialog<ImageSource>(
                AlertDialog(
                  title: const Text(
                    'Pilih Salah satu',
                    style: TextStyle(fontWeight: Fw.bold),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Hi.cameraLens),
                        title: const Text('Kamera'),
                        onTap: () => Get.back(result: ImageSource.camera),
                      ),
                      ListTile(
                        leading: const Icon(Hi.image02),
                        title: const Text('Galeri'),
                        onTap: () => Get.back(result: ImageSource.gallery),
                      ),
                    ],
                  ),
                ),
              );

              if (source != null) {
                final pickedFile = await picker.pickImage(source: source);
                if (pickedFile != null) {
                  final path = pickedFile.path;
                  forms.set('image', path);
                  controller.fileName.value = path;
                  controller.file = File(path);
                }
              }
            },
          ),
          Obx(() => controller.fileName.value.isEmpty
              ? const None()
              : Column(
                  children: [
                    LzImage(previewable: true, controller.file, size: 100),
                  ],
                ).start),
        ],
      ),
    );
  }
}
