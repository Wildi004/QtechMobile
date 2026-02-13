import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/role.dart';
import 'package:qrm_dev/app/modules/role_akses/controllers/create_role_akses_controller.dart';

class CreateRoleAksesView extends GetView<CreateRoleAksesController> {
  final Role? data;

  const CreateRoleAksesView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateRoleAksesController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      title: const Text(
        'Role/Jabatan',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LzForm.input(
              hint: 'divison', label: 'divison', model: forms.key('divison')),
          LzForm.input(hint: 'role', label: 'role', model: forms.key('role')),
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
