import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/service_aset/service_aset.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Service%20Aset%20Logistik/create_sercice_kendaraan_logistik_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateServiceKendaraanLogiastikView
    extends GetView<CreateSerciceKendaraanLogistikController> {
  final ServiceAset? data;
  const CreateServiceKendaraanLogiastikView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateSerciceKendaraanLogistikController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
        appBar: CustomAppbar(
          title: 'Form Add Service Kendaraan',
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
            LzForm.checkbox(model: forms.key('jenis_aset'), options: const [
              'AsetKendaraan',
            ]),
            LzForm.select(
              hint: 'Masukkan Nama Kendaraan',
              label: 'Nama Kendaraan',
              style: OptionPickerStyle(withSearch: true),
              model: forms.key('aset_id'),
              onTap: () => controller.openKendaraan(),
            ),
            LzForm.input(
              hint: 'Pilih Tanggal Service',
              maxLines: 99,
              label: 'Tanggal Service',
              suffixIcon: Hi.calendar02,
              model: forms.key('tgl_service'),
              onTap: () {
                LzPicker.date(context,
                    minDate: DateTime(1900),
                    initDate: forms.get('tgl_service').toDate(),
                    onSelect: (date) {
                  forms.set('tgl_service', date.format());
                });
              },
            ),
            LzForm.input(
              hint: 'Masukkan Tempat Service',
              maxLines: 99,
              label: 'Tempat Service',
              model: forms.key('tempat_service'),
            ),
            LzForm.input(
              hint: 'Masukkan Biaya Service',
              maxLines: 99,
              formatters: [Formatter.currency()],
              label: 'Biaya',
              model: forms.key('biaya'),
            ),
            LzForm.input(
              hint: 'Masukkan Keterangan',
              maxLines: 99,
              label: 'Keterangan',
              model: forms.key('keterangan'),
            ),
            LzForm.select(
              hint: 'Diservice Oleh',
              style: OptionPickerStyle(withSearch: true),
              label: 'Diservice Oleh',
              model: forms.key('diservice_oleh'),
              onTap: () => controller.openUser(),
            ),
            LzForm.input(
              hint: 'Upload nota',
              label: 'Nota',
              model: forms.key('nota'),
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
                    forms.set('nota', path);
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
                  ).start)
          ],
        ));
  }
}
