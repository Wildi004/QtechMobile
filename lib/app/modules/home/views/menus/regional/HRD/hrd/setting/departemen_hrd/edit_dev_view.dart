import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/departemen.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_setting_controller/setting_dev_controller/edit_dev_controller.dart';

class EditDevDialog extends StatelessWidget {
  final Departemen? data;
  const EditDevDialog({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditDevController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return AlertDialog(
      title: const Text(
        'Edit Departemen',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: LzListView(
          shrinkWrap: true,
          children: [
            LzForm.input(
              label: 'Edit Departemen',
              hint: 'Masukkan Nama.',
              model: forms.key('departemen'),
            ),
          ],
        ),
      ),
      actions: [
        LzButton(
          text: data == null ? 'Submit' : 'Update',
          onTap: () {
            controller.onSubmit(data?.id);
          },
        ).margin(all: 10),
      ],
    );
  }
}
