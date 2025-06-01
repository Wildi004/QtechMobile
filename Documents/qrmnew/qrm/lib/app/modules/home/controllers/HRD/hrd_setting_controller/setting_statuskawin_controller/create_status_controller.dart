import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/status_kawin.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class CreateStatusController extends GetxController with Apis {
  final forms = LzForm.make(['keterangan']);
  File? file;
  RxString fileName = ''.obs;
  Rxn<StatusKawin> status = Rxn<StatusKawin>();

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
            Toast.success('Data berhasil ditambahkan, silahkan refresh');
          }
        } else {
          final res = await api.statusKawin
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Toast.success('Data berhasil diperbarui');

          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
