// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Bindings;
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/user.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class PasswordController extends GetxController with Apis {
  final forms = LzForm.make(
      ['current_password', 'new_password', 'new_password_confirmation']);
  Future getUserLogged() async {
    try {
      final auth = await Auth.user();
      final res = await api.user.getData(auth.id!);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future onSubmit() async {
    try {
      final form = forms.validate(required: [
        '*'
      ], match: [
        'new_password:new_password_confirmation'
      ], message: {
        'current_password': 'Password lama harus diisi',
        'new_password': 'Password baru harus diisi',
        'new_password_confirmation:match': 'Konfirmasi password tidak sesuai'
      });

      if (form.ok) {
        final payload = form.value;
        final res =
            await api.user.updatePassword(payload).ui.loading('Memperbarui...');

        if (res.status) {
          Get.back(result: res.data);

          Get.snackbar('Berhasil', res.message ?? '');
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future getUserData() async {
    try {
      Toast.overlay('Loading...');
      final auth = await Auth.user();
      final res = await api.user.getCurrent(auth.id!);
      Toast.dismiss();

      final data = User.fromJson(res.data ?? {});
      forms.fill({});
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future onPageInit() async {
    try {
      await getUserLogged();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    Bindings.onRendered(() {
      getUserData();
    });
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }
}
