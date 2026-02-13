import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/data_mandor/data_mandor.dart';
import 'package:qrm_dev/app/modules/data_mandor/controllers/edit_data_mandor_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/image_picker.dart';

class EditDataMandorView extends GetView<EditDataMandorController> {
  final DataMandor? data;
  const EditDataMandorView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EditDataMandorController());
    final forms = controller.forms;

    if (data != null) {
      final json = data!.toJson();

      forms.fill(json);

      // Ambil files dari detail
      if (json['detail'] != null) {
        final files =
            (json['detail'] as List).map((e) => e['files'].toString()).toList();

        forms.set('files[]').val(files.join(', '));
      }
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Edit Data Mandor',
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
            hint: 'Inputkan nama',
            label: 'Nama',
            model: forms.key('nama'),
          ),
          LzForm.input(
            hint: 'Inputkan Alamat KTP',
            label: 'Alamat KTP',
            model: forms.key('alamat_ktp'),
          ),
          LzForm.input(
            hint: 'Inputkan No HP',
            label: 'No HP',
            model: forms.key('no_hp'),
          ),
          LzForm.input(
            hint: 'Inputkan Alamat Domisili',
            label: 'Alamat Domisili',
            model: forms.key('alamat_domisili'),
          ),
          LzForm.input(
            hint: 'Inputkan No KTP',
            label: 'No KTP',
            model: forms.key('ktp'),
          ),
          LzForm.input(
            hint: 'Inputkan Status',
            label: 'Status',
            model: forms.key('status'),
          ),
          LzForm.input(
            hint: 'Inputkan Harga',
            label: 'Harga',
            model: forms.key('harga'),
          ),
          LzForm.input(
            hint: 'Inputkan Ketepatan Waktu',
            label: 'Ketepatan Waktu',
            model: forms.key('ketepatan_waktu'),
          ),
          LzForm.input(
            hint: 'Inputkan Kualitas Pekerjaan',
            label: 'Kualitas Pekerjaan',
            model: forms.key('kualitas_pekerjaan'),
          ),
          LzForm.input(
            hint: 'Inputkan Kepatuhan Safety',
            label: 'Kepatuhan Safety',
            model: forms.key('kepatuhan_safety'),
          ),
          LzForm.input(
            hint: 'Inputkan Komunikasi',
            label: 'Komunikasi',
            model: forms.key('komunikasi'),
          ),
          LzForm.input(
            hint: 'Inputkan Spesialis',
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
