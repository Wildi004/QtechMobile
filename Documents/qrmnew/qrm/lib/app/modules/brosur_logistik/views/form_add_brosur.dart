import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/brosur_logistik.dart';
import 'package:qrm/app/modules/brosur_logistik/controllers/form_brosur_controller.dart';

class FormAddBrosur extends GetView<FormBrosurController> {
  final BrosurLogistik? data;
  const FormAddBrosur({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormBrosurController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit brosur",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 91, 122),
      ),
      body: LzListView(
        gap: 25,
        children: [
          LzForm.input(
              hint: 'Inputkan nama tkdn',
              label: 'Nama TKDN',
              model: forms.key('nama')),
          LzForm.input(
              hint: 'Inputkan tanggal',
              label: 'Tanggal Upload',
              model: forms.key('tgl_upload'),
              suffixIcon: Hi.calendar02,
              onTap: () {
                LzPicker.date(context,
                    initDate: forms.get('tgl_upload').toDate(),
                    onSelect: (date) {
                  forms.set('tgl_upload', date.format());
                });
              }),
          // LzForm.input(
          //     hint: 'Pilih Gambar',
          //     label: 'Pilih gambar tkdn',
          //     model: forms.key('image'),
          //     suffixIcon: Hi.image01,
          //     onTap: () {
          //       Pickers.image(then: (file) {
          //         if (file != null) {
          //           forms.set('image', file.path);
          //           controller.fileName.value = file.path;
          //           controller.file = File(file.path);
          //         }
          //       });
          //     }),
          // Obx(() => controller.fileName.value.isEmpty
          //     ? const None()
          //     : Column(
          //         children: [
          //           LzImage(controller.file, size: 100),
          //         ],
          //       ).start)
        ],
      ),
      bottomNavigationBar: LzButton(
        text: data == null ? 'Submit' : 'Update',
        onTap: () {
          controller.onSubmit(data?.id);
        },
      ).margin(all: 20),
    );
  }
}
