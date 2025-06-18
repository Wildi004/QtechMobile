import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/status_kawin.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_setting_controller/setting_statuskawin_controller/create_status_controller.dart';

class CreateStatusView extends GetView<CreateStatusController> {
  final StatusKawin? data;

  const CreateStatusView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateStatusController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      title: const Text('Form Status Kawin'),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LzForm.input(
                hint: 'keterangan',
                label: 'keterangan',
                model: controller.forms.key('keterangan'),
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
