// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';

import '../controllers/login_controller.dart';

class FormInputEmail extends GetView<LoginController> {
  final BuildContext context;
  const FormInputEmail({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginController());
    void requestOtp() async {
      final ok = await controller.requestOtp();
      if (ok) {
        // OTP berhasil dikirim
        Get.snackbar(
          'Berhasil',
          'Kode OTP telah dikirim ke ${controller.email.text.trim()}, silahkan cek gmail anda',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
        );
      }
    }

    return SafeArea(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            padding: Ei.only(b: context.viewInsets.bottom),
            child: LzTextField(
              hint: 'Ketik alamat email',
              controller: controller.email,
              autofocus: true,
              onSubmit: (_) => requestOtp(),
              border: Ltf.none,
              suffixIcon: SuffixBuilder(
                controller: controller.email,
                builder: (value) {
                  if (value.isEmpty) return const None();
                  return Touch(
                    onTap: () => requestOtp(),
                    padding: Ei.sym(v: 14, h: 16),
                    child: Text('Kirim', style: Gfont.bold),
                  );
                },
              ),
            ),
          ),
        ],
      ).min,
    );
  }
}
