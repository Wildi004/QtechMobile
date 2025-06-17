import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/departemen.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_setting_controller/setting_dev_controller/create_dev_controller.dart';

class ShowForm extends GetView<CreateDevController> {
  final Departemen? data;

  const ShowForm({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateDevController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      title: const Text(
        'Tambah Departemen',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LzForm.input(
              hint: 'Departemen',
              label: 'Departemen',
              model: forms.key('departemen')),
          LzForm.select(
            hint: 'Company',
            label: 'Company',
            model: forms.key('company_id'),
            onTap: () async {
              final data = await controller.getAktif().overlay();
              controller.forms
                  .set('company_id')
                  .options(data.labelValue('name', 'id'));
            },
          ),
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
