import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20legal/dok_ken_legal.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/aset_kantor_controller/image_token_aset.dart';
import 'package:qrm_dev/app/modules/home/controllers/LEGAL/Dokumentasi%20Kendaraan%20Legal/edit_dok_ken_legal_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class EditDokKenView extends GetView<EditDokKenLegalController> {
  final DokKenLegal? data;
  const EditDokKenView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final imageC = Get.put(ImageFileTokenController());

    Get.lazyPut(() => EditDokKenLegalController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.getDetail(data!.id!);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (data?.image != null && data!.image!.isNotEmpty) {
        imageC.loadImage(data!.image!);
      }
    });

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
            maxLines: 99,
            hint: 'Masukkan Keterangan',
            label: 'Keterangan',
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
          Obx(() {
            final bytes = imageC.imageBytes.value;
            return bytes != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      bytes,
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  )
                : CustomLoading();
          }),
          Text('Ganti Dengan :'),
          Obx(() => controller.fileName.value.isEmpty
              ? const None()
              : Column(
                  children: [
                    LzImage(
                      controller.file,
                      size: 100,
                      previewable: true,
                    ),
                  ],
                ).start),
        ],
      ),
    );
  }
}

/*


 */
