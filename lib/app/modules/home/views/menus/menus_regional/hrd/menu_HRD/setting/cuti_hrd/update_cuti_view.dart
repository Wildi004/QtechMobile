import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/cuti.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_setting_controller/setting_cuti/update_cuti_controller.dart';

class UpdateCutiView extends GetView<UpdateCutiController> {
  final Cuti? data;

  const UpdateCutiView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => UpdateCutiController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      title: const Text(
        'Edit cuti',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LzForm.input(
              hint: 'Jumlah cuti',
              label: 'Jumlah cuti',
              model: forms.key('jml_cuti')),
          const SizedBox(height: 20),
          LzButton(
            text: data == null ? 'Submit' : 'Update',
            onTap: () {
              controller.onSubmit(data?.id);
            },
          ).margin(all: 20),
        ],
      ),
    );
  }
}
