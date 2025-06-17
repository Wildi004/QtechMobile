// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/login/controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  final String email;
  const ForgotPasswordView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ForgotPasswordController());
    final forms = controller.forms;
    forms.reset();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: LzListView(
        gap: 25,
        children: [
          LzForm.input(
              label: 'Token',
              hint: 'Masukkan token (lihat email)',
              model: forms.key('token'),
              maxLength: 5,
              keyboard: Tit.number),
          LzForm.input(
              label: 'Password',
              hint: 'Masukkan password baru',
              model: forms.key('password'),
              suffix: Obscure()),
          LzForm.input(
              label: 'Konfirmasi Password',
              hint: 'Masukkan konfirmasi password',
              model: forms.key('password_confirmation'),
              suffix: Obscure()),
          LzButton(
              text: 'Reset Password',
              onTap: () async {
                forms.set('email', email);
                final ok = await controller.onSubmit();

                if (ok == true) {
                  context.lz.pop();
                }
              }).margin(blr: 20).lz.shadowed(context),
        ],
      ),
    );
  }
}
