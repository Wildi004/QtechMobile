import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/brosur_logistik.dart';
import 'package:qrm_dev/app/modules/brosur_logistik/controllers/form_brosur_controller.dart';

class DetailBrosurLogView extends GetView<FormBrosurController> {
  final BrosurLogistik? data;

  const DetailBrosurLogView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormBrosurController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      title: Row(
        mainAxisAlignment: Maa.spaceBetween,
        children: [
          const Text(
            'Detail Brosur',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LzForm.input(
              hint: 'Nama',
              maxLines: 99,
              enabled: false,
              label: 'Nama',
              model: forms.key('nama')),
          15.height,
          LzForm.input(
              label: 'Tanggal Upload',
              enabled: false,
              model: forms.key('tgl_upload')),
        ],
      ),
    );
  }
}
