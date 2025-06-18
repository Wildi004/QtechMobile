import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/regional.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_setting_controller/setting_regional/form_regional_controller.dart';

class FormRegionalView extends GetView<FormRegionalController> {
  final Regional? data;

  const FormRegionalView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormRegionalController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      title: const Text('Form Regional'),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LzForm.input(
                hint: 'regional',
                label: 'regional',
                model: controller.forms.key('regional'),
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
