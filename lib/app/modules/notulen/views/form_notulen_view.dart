import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/notulen/notulen.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/aset_kantor_controller/image_token_aset.dart';
import 'package:qrm_dev/app/modules/notulen/views/list_members_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

import '../controllers/form_notulen_controller.dart';

class FormNotulenView extends GetView<FormNotulenController> {
  final Notulen? data;

  const FormNotulenView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormNotulenController());
    final imageC = Get.put(ImageFileTokenController());

    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
      controller.getDetailAset(data!.id!);

      controller.loadMembersFromNotulen(data!);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (data?.image != null && data!.image!.isNotEmpty) {
        imageC.loadImage(data!.image!);
      }
    });
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Buat Notulen',
        actions: [
          IconButton(
              onPressed: () {
                controller.onSubmit(data?.id);
              },
              icon: Icon(Hi.tick02))
        ],
      ).appBar,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: LzListView(
          autoCache: true,
          gap: 10,
          children: [
            LzForm.input(
                label: 'judul',
                model: forms.key('judul'),
                hint: 'Judul Notulen'),
            Row(
              children: [
                Expanded(
                    child: LzForm.input(
                        label: 'Tanggal Rapat',
                        model: forms.key('tgl_rapat'),
                        suffixIcon: Hi.calendar02,
                        hint: 'Tanggal Rapat',
                        onTap: () {
                          LzPicker.date(context,
                              initDate: forms.get('tgl_rapat').toDate(),
                              onSelect: (date) {
                            forms.set('tgl_rapat', date.format());
                          });
                        })),
                Expanded(
                    child: LzForm.input(
                  label: 'Jam',
                  hint: 'Pilih waktu',
                  readOnly: true,
                  model: controller.forms.key('jam'),
                  suffixIcon: Icons.access_time,
                  onTap: () async {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      final now = DateTime.now();
                      final dt = DateTime(now.year, now.month, now.day,
                          pickedTime.hour, pickedTime.minute);
                      final formatted = DateFormat('HH:mm').format(dt);

                      controller.forms.set('jam', formatted);
                    }
                  },
                )),
              ],
            ).gap(10),
            Column(
              spacing: 7,
              children: [
                Row(
                  children: [
                    Text('Jumlah Peserta', style: Gfont.fs14),
                    Touch(
                      onTap: () => Get.to(() => ListMembersView()),
                      child: Text('Tambah Peserta', style: Gfont.blue),
                    )
                  ],
                ).between,
                LzForm.input(
                    hint: 'Masukkan jumlah Peserta',
                    model: forms.key('jml_peserta')),
              ],
            ).start,
            LzForm.input(
                maxLines: 20,
                hint: 'Isi Notulen',
                label: 'isi',
                model: forms.key('isi')),
            LzForm.select(
              style: OptionPickerStyle(withSearch: true),
              hint: 'Sifat',
              label: 'sifat',
              model: forms.key('sifat'),
              onTap: () async {
                final data = await controller.getSifat().overlay();
                controller.forms
                    .set('sifat')
                    .options(data.labelValue('name', 'id'));
              },
            ),
            LzForm.input(
              hint: 'Pilih Gambar',
              label: 'Pilih gambar',
              model: forms.key('image'),
              suffixIcon: Hi.image01,
              // onTap: () {
              //   Pickers.image(then: (file) {
              //     if (file != null) {
              //       forms.set('image', file.path);
              //       controller.fileName.value = file.path;
              //       controller.file = File(file.path);
              //     }
              //   });
              // }
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
                      LzImage(controller.file, size: 100),
                    ],
                  ).start),
            20.height,
            // LzButton(
            //   text: data == null ? 'Submit' : 'Update',
            //   onTap: () {},
            // ).margin(all: 20),
          ],
        ),
      ),
    );
  }
}
