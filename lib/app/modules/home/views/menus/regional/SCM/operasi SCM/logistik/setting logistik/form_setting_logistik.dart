import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/satuan_logistik.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Setting%20Logistik/form_setting_logistik_controller.dart';

class FormSettingLogistik extends GetView<FormSettingLogistikController> {
  final SatuanLogistik? data;

  const FormSettingLogistik({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormSettingLogistikController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      title: const Text('Form'),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LzForm.input(
                hint: 'Satuan',
                label: 'Satuan',
                model: controller.forms.key('satuan'),
              ),
              const SizedBox(height: 20),
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
