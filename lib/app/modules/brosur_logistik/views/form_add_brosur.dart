import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/brosur_logistik.dart';
import 'package:qrm_dev/app/modules/brosur_logistik/controllers/form_brosur_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

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
      appBar: CustomAppbar(
        title: 'Edit brosur',
        actions: [
          IconButton(
              onPressed: () {
                controller.onSubmit(data?.id);
              },
              icon: Icon(Hi.tick03))
        ],
      ).appBar,
      body: LzListView(
        gap: 25,
        children: [
          LzForm.input(
              hint: 'Inputkan nama brosur',
              label: 'Nama brosur',
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
    );
  }
}
