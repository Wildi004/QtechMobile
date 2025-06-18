import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/brosur_logistik.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class CreateBrosurController extends GetxController with Apis {
  final forms = LzForm.make(['nama', 'tgl_upload', 'image']);
  File? file;
  RxString fileName = ''.obs;
  Rxn<BrosurLogistik> brosur = Rxn<BrosurLogistik>();

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['nama', 'tgl_upload']);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;

        if (file != null) {
          payload['image'] = await api.toFile(file!.path);
        }

        if (id == null) {
          final res = await api.brosurLogistik
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
          }
        } else {
          final res = await api.brosurLogistik
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
