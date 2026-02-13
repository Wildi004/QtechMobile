import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/data_mandor/data_mandor.dart';
import 'package:qrm_dev/app/modules/data_mandor/controllers/edit_data_mandor_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/image_picker.dart';

class AddDataMandorView extends GetView<EditDataMandorController> {
  final DataMandor? data;
  const AddDataMandorView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EditDataMandorController());
    final forms = controller.forms;

    if (data != null) {
      final json = data!.toJson();

      forms.fill(json);

      if (json['detail'] != null) {
        final files =
            (json['detail'] as List).map((e) => e['files'].toString()).toList();

        forms.set('files[]').val(files.join(', '));
      }
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Buat Data Mandor',
        actions: [
          IconButton(
              onPressed: () {
                controller.onSubmit(data?.resourceId);
              },
              icon: Icon(Hi.tick03))
        ],
      ).appBar,
      body: LzListView(
        gap: 10,
        children: [
          LzForm.input(
            maxLines: 99,
            hint: 'Inputkan nama',
            label: 'Nama',
            model: forms.key('nama'),
          ),
          LzForm.input(
            maxLines: 99,
            label: 'Alamat KTP',
            hint: 'Inputkan Alamat KTP',
            model: forms.key('alamat_ktp'),
          ),
          LzForm.input(
            maxLines: 99,
            hint: 'Inputkan No HP',
            label: 'No HP',
            model: forms.key('no_hp'),
          ),
          LzForm.input(
            maxLines: 99,
            label: 'Alamat Domisili',
            hint: 'Inputkan Alamat Domisili',
            model: forms.key('alamat_domisili'),
          ),
          LzForm.input(
            maxLines: 99,
            label: 'No KTP',
            hint: 'Inputkan No KTP',
            model: forms.key('ktp'),
          ),
          LzForm.input(
            maxLines: 99,
            label: 'Status',
            hint: 'Inputkan Status',
            model: forms.key('status'),
          ),
          LzForm.input(
            label: 'Harga',
            maxLines: 99,
            hint: 'Inputkan Harga',
            model: forms.key('harga'),
          ),
          LzForm.input(
            maxLines: 99,
            label: 'Ketepatan Waktu',
            hint: 'Inputkan Ketepatan Waktu',
            model: forms.key('ketepatan_waktu'),
          ),
          LzForm.input(
            maxLines: 99,
            label: 'Kualitas Pekerjaan',
            hint: 'Inputkan Kualitas Pekerjaan',
            model: forms.key('kualitas_pekerjaan'),
          ),
          LzForm.input(
            hint: 'Inputkan Kepatuhan Safety',
            maxLines: 99,
            label: 'Kepatuhan Safety',
            model: forms.key('kepatuhan_safety'),
          ),
          LzForm.input(
            hint: 'Inputkan Komunikasi',
            maxLines: 99,
            label: 'Komunikasi',
            model: forms.key('komunikasi'),
          ),
          LzForm.input(
            hint: 'Inputkan Spesialis',
            maxLines: 99,
            label: 'Spesialis',
            model: forms.key('spesialis'),
          ),
          LzForm.input(
            hint: 'Pilih gambar',
            label: 'Pilih gambar',
            model: forms.key('files[]'),
            suffixIcon: Hi.image01,
            onTap: () {
              Pickers.image(then: (file) {
                if (file != null) {
                  forms.set('files[]', file.path);
                  controller.fileImage = file;
                }
              });
            },
          ),
          Obx(() => controller.fileName.value.isEmpty
              ? const None()
              : Column(children: [LzImage(controller.file, size: 100)]).start),
        ],
      ),
    );
  }
}
