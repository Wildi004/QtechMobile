import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/kendaraan_logistik.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Kendaraan%20Logistik/create_kendaraan_logistik_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateKendaraanLogistikView
    extends GetView<CreateKendaraanLogistikController> {
  final KendaraanLogistik? data;
  const CreateKendaraanLogistikView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateKendaraanLogistikController());
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
            hint: 'Masukkan Kode Aset',
            label: 'Kode Aset',
            model: forms.key('kode_aset'),
          ),
          LzForm.input(
            hint: 'Masukkan Nama Aset',
            label: 'Nama Aset',
            model: forms.key('nama_aset'),
          ),
          LzForm.input(
            hint: 'Masukkan No Pol',
            label: 'Nomor Polisi',
            model: forms.key('no_pol'),
          ),
          Intrinsic(
            gap: 10,
            children: [
              LzForm.input(
                hint: 'Masukkan Tanggal Kir',
                label: 'Tanggal Kir',
                model: forms.key('tgl_qir'),
                suffixIcon: Hi.calendar02,
                onTap: () {
                  LzPicker.date(context,
                      minDate: DateTime(1900),
                      initDate: forms.get('tgl_qir').toDate(),
                      onSelect: (date) {
                    forms.set('tgl_qir', date.format());
                  });
                },
              ),
              LzForm.input(
                hint: 'Masukan Tanggal Beli',
                label: 'Tanggal Beli',
                model: forms.key('tgl_beli'),
                keyboard: TextInputType.number,
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
            ],
          ),
          Intrinsic(
            gap: 10,
            children: [
              LzForm.input(
                hint: 'Masukan Tanggal Samsat',
                label: 'Tanggal Samsat',
                model: forms.key('tgl_samsat'),
                keyboard: TextInputType.number,
                suffixIcon: Hi.calendar02,
                onTap: () {
                  LzPicker.date(context,
                      minDate: DateTime(1900),
                      initDate: forms.get('tgl_samsat').toDate(),
                      onSelect: (date) {
                    forms.set('tgl_samsat', date.format());
                  });
                },
              ),
              LzForm.input(
                hint: 'Masukkan jumlah',
                label: 'Jumlah',
                model: forms.key('jumlah'),
              ),
            ],
          ),
          LzForm.input(
            hint: 'Masukkan harga perolehan',
            label: 'Harga Perolehan',
            formatters: [Formatter.currency()],
            model: forms.key('harga_perolehan'),
          ),
          LzForm.input(
            hint: 'Masukkan penanggung jawab',
            label: 'Penanggung Jawab',
            model: forms.key('penanggung_jawab'),
          ),
          Intrinsic(
            gap: 10,
            children: [
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
              LzForm.input(
                hint: 'Upload Foto/Gambar',
                label: 'Gambar',
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
            ],
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
