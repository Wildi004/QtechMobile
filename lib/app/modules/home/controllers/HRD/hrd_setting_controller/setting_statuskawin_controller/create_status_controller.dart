import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/status_kawin.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class CreateStatusController extends GetxController with Apis {
  final forms = LzForm.make(['keterangan']);
  File? file;
  RxString fileName = ''.obs;
  Rxn<StatusKawin> status = Rxn<StatusKawin>();
  void resetForm() {
    forms.set('keterangan', '');
  }

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['keterangan']);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;

        if (id == null) {
          final res = await api.statusKawin
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message.toString());
          }
        } else {
          final res = await api.statusKawin
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message.toString());
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
