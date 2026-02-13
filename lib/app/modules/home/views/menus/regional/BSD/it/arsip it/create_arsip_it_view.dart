import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/arsip_it.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Arsip%20IT/create_arsip_it_controller.dart';

class CreateArsipItView extends GetView<CreateArsipItController> {
  final ArsipIt? data;

  const CreateArsipItView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateArsipItController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      title: const Text(
        'Form Arsip',
        style: TextStyle(color: Colors.black, fontWeight: Fw.bold),
      ),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LzForm.input(
                hint: 'Nama Dokumen',
                label: 'Nama Dokumen',
                model: controller.forms.key('nama'),
              ),
              LzForm.input(
                hint: 'Keterangan',
                model: controller.forms.key('keterangan'),
                label: 'Keterangan',
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
              LzButton(
                text: data == null ? 'Submit' : 'Update',
                onTap: () {
                  controller.onSubmit(data?.id);
                },
              ).margin(all: 20),
            ],
          );
        },
      ),
    );
  }
}
