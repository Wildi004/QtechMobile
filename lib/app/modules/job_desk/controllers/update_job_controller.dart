import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/job_desk.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class UpdateJobController extends GetxController with Apis {
  final forms = LzForm.make([
    'image',
  ]);
  File? file;
  RxString fileName = ''.obs;
  Rxn<JobDesk> jobDesk = Rxn<JobDesk>();

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;
        logg(form.error);
        payload['user_id'] = auth.id;

        if (file != null) {
          payload['image'] = await api.toFile(file!.path);
        }

        if (id == null) {
          final res = await api.jobDesk
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
          }
        } else {
          final res = await api.jobDesk
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
