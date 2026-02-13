import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20rnd/arsip_rnd.dart';
import 'package:qrm_dev/app/modules/home/controllers/RND/Arsip%20RND/create_arsip_rnd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateArsipRndView extends GetView<CreateArsipRndController> {
  final ArsipRnd? data;

  const CreateArsipRndView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateArsipRndController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Tambah Arsip RND',
        actions: [
          IconButton(
            icon: const Icon(Hi.tick03),
            onPressed: () {
              controller.onSubmit(data?.id);
            },
          )
        ],
      ),
      body: LzListView(
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
              maxLines: 3),
          LzForm.input(
            hint: 'Upload File',
            model: controller.forms.key('image'),
            label: 'Upload File',
            suffixIcon: Hi.image01,
            readOnly: true,
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
        ],
      ),
    );
  }
}
