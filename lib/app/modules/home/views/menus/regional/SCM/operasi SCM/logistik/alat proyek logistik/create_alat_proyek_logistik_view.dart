import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/alat_proyek.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Alat%20Proyek/create_alat_proyek_logistik_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateAlatProyekLogistikView
    extends GetView<CreateAlatProyekLogistikController> {
  final AlatProyek? data;
  const CreateAlatProyekLogistikView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateAlatProyekLogistikController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
        appBar: CustomAppbar(
          title: 'Form Add Alat Proyek',
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
          gap: 10,
          children: [
            LzForm.input(
              hint: 'Masukkan Kode Alat',
              label: 'Kode Alat',
              maxLines: 99,
              model: forms.key('kode_alat'),
            ),
            LzForm.input(
              hint: 'Masukkan Type',
              maxLines: 99,
              label: 'Type',
              model: forms.key('type'),
            ),
            LzForm.input(
              hint: 'Masukkan Nama Alat',
              maxLines: 99,
              label: 'Nama Alat',
              model: forms.key('nama_alat'),
            ),
            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                  hint: 'Masukkan Jumlah',
                  formatters: [Formatter.currency()],
                  label: 'Jumlah',
                  keyboard: TextInputType.number,
                  model: forms.key('jumlah'),
                ),
                LzForm.select(
                  hint: 'Pilih Status',
                  label: 'Status',
                  model: forms.key('status'),
                  onTap: () async {
                    final data = await controller.getStatus().overlay();
                    controller.forms
                        .set('status')
                        .options(data.labelValue('name', 'id'));
                  },
                ),
              ],
            ),
            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                  hint: 'Masukkan Harga Satuan',
                  formatters: [Formatter.currency()],
                  label: 'Harga Satuan',
                  keyboard: TextInputType.number,
                  model: forms.key('harga_satuan'),
                ),
                LzForm.input(
                  hint: 'Masukkan Harga Perolehan',
                  label: 'Harga Perolehan',
                  keyboard: TextInputType.number,
                  formatters: [Formatter.currency()],
                  model: forms.key('harga_perolehan'),
                ),
              ],
            ),
            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                  label: 'Tanggal Beli',
                  hint: 'Format: YYYY-MM-DD',
                  model: forms.key('tgl_beli'),
                  suffixIcon: Hi.calendar02,
                  onTap: () {
                    LzPicker.date(context,
                        minDate: DateTime(1900),
                        initDate: forms.get('tgl_beli').toDate(),
                        onSelect: (date) {
                      forms.set('tgl_beli', date.format());
                    });
                  },
                ),
                LzForm.input(
                  label: 'Tanggal Service',
                  hint: 'Format: YYYY-MM-DD',
                  model: forms.key('tgl_service'),
                  suffixIcon: Hi.calendar02,
                  onTap: () {
                    LzPicker.date(context,
                        minDate: DateTime(1900),
                        initDate: forms.get('tgl_service').toDate(),
                        onSelect: (date) {
                      forms.set('tgl_service', date.format());
                    });
                  },
                ),
              ],
            ),
            Intrinsic(
              gap: 10,
              children: [
                LzForm.select(
                  style: OptionPickerStyle(withSearch: true),
                  hint: 'Masukkan Reg',
                  label: 'Regional',
                  onTap: () => controller.openReg(),
                  model: forms.key('reg_id'),
                ),
                LzForm.select(
                  style: OptionPickerStyle(withSearch: true),
                  label: 'Departemen',
                  hint: 'Klik untuk memilih departemen',
                  model: forms.key('dep_id'),
                  onTap: () => controller.openDep(),
                ),
              ],
            ),
            LzForm.select(
                hint: 'Masukkan Proyek',
                label: 'Proyek',
                model: forms.key('proyek_item_id'),
                style: OptionPickerStyle(maxLines: 3, withSearch: true),
                onTap: controller.openProyek,
                onChange: (value) {
                  controller.forms.set('pm', Option('')).enable();
                }),
            LzForm.select(
                hint: 'Masukkan Nama PM',
                enabled: false,
                label: 'PM',
                model: forms.key('pm'),
                onTap: controller.getPM),
            LzForm.input(
              hint: 'Masukkan Keterangan',
              label: 'Keterangan',
              maxLines: 3,
              model: forms.key('keterangan'),
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
            ]),
            Obx(() => controller.fileName.value.isEmpty
                ? const None()
                : Column(
                    children: [
                      LzImage(previewable: true, controller.file, size: 100),
                    ],
                  ).start),
          ],
        ));
  }
}
