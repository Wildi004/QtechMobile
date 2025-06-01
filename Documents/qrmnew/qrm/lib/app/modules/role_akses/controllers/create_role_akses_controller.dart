import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/role.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class CreateRoleAksesController extends GetxController with Apis {
  final forms = LzForm.make([
    'divison',
    'role',
  ]);
  File? file;
  RxString fileName = ''.obs;
  Rxn<Role> tkdn = Rxn<Role>();

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;

        if (id == null) {
          final res =
              await api.role.createData(payload).ui.loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
          }
        } else {
          final res = await api.role
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
