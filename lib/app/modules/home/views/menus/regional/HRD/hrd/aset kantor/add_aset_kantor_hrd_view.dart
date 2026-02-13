import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/aset_kantor_hrd.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/aset_kantor_controller/add_aset_kantor_hrd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class AddAsetKantorHrdView extends GetView<AddAsetKantorHrdController> {
  final AsetKantorHrd? data;
  const AddAsetKantorHrdView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddAsetKantorHrdController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Form Add Aset Kantor',
        actions: [
          IconButton(
            onPressed: () {
              controller.onSubmit(data?.id);
              logg('Ini Idnya ${data?.id}');
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
            hint: 'Masukkan Kode Aset',
            label: 'Kode Aset',
            model: forms.key('kode_aset'),
          ),
          LzForm.input(
            maxLines: 99,
            hint: 'Masukkan Nama Aset',
            label: 'Nama Aset',
            model: forms.key('nama_aset'),
          ),
          Intrinsic(gap: 10, children: [
            LzForm.input(
              maxLines: 99,
              hint: 'Jumlah Aset',
              label: 'Jumlah',
              model: forms.key('jumlah'),
              keyboard: TextInputType.number,
            ),
            LzForm.input(
              hint: 'Harga Perolehan',
              label: 'Harga Perolehan',
              formatters: [Formatter.currency()],
              model: forms.key('harga_perolehan'),
              keyboard: Tit.number,
            ),
          ]),
          LzForm.input(
            labelStyle: TextStyle(),
            label: 'Tanggal Beli',
            hint: 'Format: YYYY-MM-DD',
            model: forms.key('tgl_beli'),
            suffixIcon: Hi.calendar02,
            onTap: () {
              LzPicker.date(context,
                  minDate: DateTime(1900),
                  initDate: forms.get('tgl_beli').toDate(), onSelect: (date) {
                forms.set('tgl_beli', date.format());
              });
            },
          ),
          LzForm.input(
            hint: 'Penanggung Jawab',
            label: 'Penanggung Jawab',
            model: forms.key('penanggung_jawab'),
          ),
          Intrinsic(gap: 10, children: [
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
            LzForm.select(
              hint: 'Status Aset',
              style: OptionPickerStyle(withSearch: true),
              label: 'Status Aset',
              model: forms.key('status'),
              onTap: () async {
                final data = await controller.getStatus().overlay();
                controller.forms
                    .set('status')
                    .options(data.labelValue('name', 'id'));
              },
            ),
          ]),
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
