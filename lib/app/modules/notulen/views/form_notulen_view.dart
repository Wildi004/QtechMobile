import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/notulen/notulen.dart';
import 'package:qrm/app/modules/notulen/views/list_members_view.dart';
import 'package:qrm/app/widgets/image_picker.dart';

import '../controllers/form_notulen_controller.dart';

class FormNotulenView extends GetView<FormNotulenController> {
  final Notulen? data;

  const FormNotulenView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormNotulenController());
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 91, 122),
        title: const Text(
          'Notulen',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Hi.file01,
                color: Colors.white,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LzListView(
          autoCache: true,
          gap: 25,
          children: [
            LzForm.input(label: 'judul', model: forms.key('judul')),
            Row(
              children: [
                Expanded(
                    child: LzForm.input(
                        label: 'tgl_rapat',
                        model: forms.key('tgl_rapat'),
                        suffixIcon: Hi.calendar02,
                        onTap: () {
                          LzPicker.date(context,
                              initDate: forms.get('tgl_rapat').toDate(),
                              onSelect: (date) {
                            forms.set('tgl_rapat', date.format());
                          });
                        })),
                Expanded(
                    child: LzForm.input(label: 'jam', model: forms.key('jam'))),
              ],
            ).gap(2),
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
            LzForm.input(label: 'isi', model: forms.key('isi')),
            LzForm.input(label: 'sifat', model: forms.key('sifat')),
            LzForm.input(
                hint: 'Pilih Gambar',
                label: 'Pilih gambar',
                model: forms.key('image'),
                suffixIcon: Hi.image01,
                onTap: () {
                  Pickers.image(then: (file) {
                    if (file != null) {
                      forms.set('image', file.path);
                      controller.fileName.value = file.path;
                      controller.file = File(file.path);
                    }
                  });
                }),
            Obx(() => controller.fileName.value.isEmpty
                ? const None()
                : Column(
                    children: [
                      LzImage(controller.file, size: 100),
                    ],
                  ).start),
            20.height,
            LzButton(
              text: data == null ? 'Submit' : 'Update',
              onTap: () {
                controller.onSubmit(data?.id);
              },
            ).margin(all: 20),
          ],
        ),
      ),
    );
  }
}
