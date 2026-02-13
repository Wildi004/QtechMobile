import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/user/controllers/form_user_controller.dart';

class FormUserView extends GetView<FormUserController> {
  const FormUserView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormUserController());

    final forms = controller.forms;

    return Unfocuser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Data Baru'),
        ),
        body: LzListView(
          gap: 25,
          children: [
            LzForm.input(
                label: 'Inputkan Nama',
                hint: 'Inputkan nama lengkap',
                model: forms.key('name')),
            LzForm.input(
                label: 'Inputkan No. Induk',
                hint: 'Inputkan nomor induk',
                keyboard: Tit.number,
                model: forms.key('no_induk'))
          ],
        ),
        bottomSheet: SizedBox(
          width: Get.width,
          child: LzButton(
            onTap: () {
              controller.onSubmit();
            },
            text: 'Simpan',
          ),
        ).margin(blr: 20),
      ),
    );
  }
}
