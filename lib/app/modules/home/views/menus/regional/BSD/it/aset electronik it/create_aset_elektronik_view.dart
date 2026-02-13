import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/aset_elektronik.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Aset%20Elektronik/create_aset_elektrinik_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateItView extends GetView<CreateAsetElektrinikController> {
  final AsetElektronik? data;
  const CreateItView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateAsetElektrinikController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        actions: [
          IconButton(
              onPressed: () {
                controller.onSubmit(data?.id);
              },
              icon: Icon(Hi.tick04))
        ],
        title: 'Buat Aset Elektronik',
      ).appBar,
      body: LzListView(
        gap: 20,
        children: [
          LzForm.input(
            maxLines: 99,
            hint: 'Masukkan Kode Aset',
            label: 'Kode Aset',
            model: forms.key('kode_asset'),
          ),
          LzForm.input(
            maxLines: 99,
            hint: 'Masukkan Nama Aset', //
            label: 'Nama Aset',
            model: forms.key('nama_asset'),
          ),
          LzForm.select(
            label: 'Pic',
            hint: 'Pilih Pic',
            onTap: () => controller.openUser(),
            model: forms.key('user_id'),
          ),
          Intrinsic(gap: 10, children: [
            LzForm.input(
              hint: 'Merk/Type',
              label: 'Merk Aset',
              model: forms.key('merk'),
            ),
            LzForm.input(
              hint: 'Harga',
              label: 'Harga',
              model: forms.key('harga'),
              keyboard: TextInputType.number,
            ),
          ]),
          Intrinsic(
            gap: 10,
            children: [
              LzForm.input(
                labelStyle: TextStyle(),
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
                labelStyle: TextStyle(),
                label: 'Tanggal Pemberian',
                hint: 'Format: YYYY-MM-DD',
                model: forms.key('tgl_pemberian'),
                suffixIcon: Hi.calendar02,
                onTap: () {
                  LzPicker.date(context,
                      minDate: DateTime(1900),
                      initDate: forms.get('tgl_pemberian').toDate(),
                      onSelect: (date) {
                    forms.set('tgl_pemberian', date.format());
                  });
                },
              ),
            ],
          ),
          LzForm.select(
            hint: 'Kondisi Aset',
            style: OptionPickerStyle(withSearch: true),
            label: 'Pilih Kondisi',
            model: forms.key('kondisi'),
            onTap: () async {
              final data = await controller.getStatus().overlay();
              controller.forms.set('kondisi').options(data.labelValue('name'));
            },
          ),
          LzForm.input(
            hint: 'keterangan',
            label: 'keterangan',
            model: forms.key('keterangan'),
          ),
          Intrinsic(
            gap: 10,
            children: [
              LzForm.input(
                hint: 'Upload Foto/Gambar Aset',
                label: 'Gambar Aset 1',
                model: forms.key('image'),
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
                hint: 'Upload Foto/Gambar Aset',
                label: 'Gambar Aset 2',
                model: forms.key('image2'),
                suffixIcon: Hi.image01,
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.image,
                  );
                  if (result != null && result.files.isNotEmpty) {
                    final path = result.files.single.path!;
                    forms.set('image2', path);
                    controller.fileName2.value = path;
                    controller.file2 = File(path);
                  }
                },
              ),
            ],
          ),
          Obx(() => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: Maa.spaceBetween,
                children: [
                  if (controller.fileName.value.isNotEmpty &&
                      controller.file != null)
                    LzImage(controller.file!, size: 100),
                  if (controller.fileName2.value.isNotEmpty &&
                      controller.file2 != null)
                    LzImage(controller.file2!, size: 100),
                ],
              )),
        ],
      ),
    );
  }
}
