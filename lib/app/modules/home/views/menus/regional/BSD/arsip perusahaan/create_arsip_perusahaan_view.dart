import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/arsip_perusahaan.dart';
import 'package:qrm_dev/app/modules/home/controllers/Arsip%20Perusahaan/create_arsip_perusahaan_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateArsipPerusahaanView
    extends GetView<CreateArsipPerusahaanController> {
  final ArsipPerusahaan? data;
  const CreateArsipPerusahaanView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateArsipPerusahaanController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Buat Arsip',
        actions: [
          IconButton(
            onPressed: () {
              logg('🔹 [LOG] Tombol submit ditekan.');
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
            hint: 'Nama Dokumen',
            label: 'Nama Dokumen',
            model: forms.key('nama'),
          ),
          Intrinsic(
            gap: 10,
            children: [
              LzForm.input(
                hint: 'Tanggal Upload',
                label: 'Tanggal Upload',
                model: forms.key('tgl_upload'),
                suffixIcon: Hi.calendar02,
                onTap: () {
                  LzPicker.date(
                    context,
                    minDate: DateTime(1900),
                    initDate: forms.get('tgl_upload').toDate(),
                    onSelect: (date) {
                      forms.set(
                          'tgl_upload', date.format('yyyy-MM-dd HH:mm:ss'));
                    },
                  );
                },
              ),
              LzForm.input(
                hint: 'Masukan Tanggal Expired',
                label: 'Tanggal Expired',
                model: forms.key('expired_date'),
                keyboard: TextInputType.number,
                suffixIcon: Hi.calendar02,
                onTap: () {
                  LzPicker.date(context,
                      minDate: DateTime(1900),
                      initDate: forms.get('expired_date').toDate(),
                      onSelect: (date) {
                    forms.set('expired_date', date.format());
                  });
                },
              ),
            ],
          ),
          LzForm.input(
            hint: 'Masukan Tanggal Berlaku',
            label: 'Tanggal Berlaku',
            model: forms.key('tgl_berlaku_dok'),
            keyboard: TextInputType.number,
            suffixIcon: Hi.calendar02,
            onTap: () {
              LzPicker.date(context,
                  minDate: DateTime(1900),
                  initDate: forms.get('tgl_berlaku_dok').toDate(),
                  onSelect: (date) {
                forms.set('tgl_berlaku_dok', date.format());
              });
            },
          ),
          LzForm.input(
            hint: 'Upload FIle',
            model: controller.forms.key('image'),
            label: 'Upload FIle',
            suffixIcon: Hi.image01,
            onTap: () async {
              final result = await FilePicker.platform.pickFiles(
                type: FileType.image,
              );
              if (result != null && result.files.isNotEmpty) {
                final path = result.files.single.path!;
                forms.set('image', path);
                controller.fileName.value = path;
                controller.file = File(path);
              }
            },
          ),
          LzForm.input(
            maxLines: 99,
            hint: 'Keterangan',
            label: 'Keterangan',
            model: forms.key('keterangan'),
          ),
        ],
      ),
    );
  }
}
