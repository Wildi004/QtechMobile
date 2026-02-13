import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/surat_direksi.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class CreateSkController extends GetxController with Apis {
  final forms = LzForm.make([
    'nama',
    'tgl_sk',
    'image',
    'no_sk',
  ]);
  File? file;
  RxString fileName = ''.obs;
  Rxn<SuratDireksi> surat = Rxn<SuratDireksi>();

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);
      logg(form);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;
        payload['created_at'] = DateTime.now().millisecondsSinceEpoch;

        payload['user_id'] = auth.id;

        if (file != null) {
          payload['image'] = await api.toFile(file!.path);
        }

        if (id == null) {
          final res = await api.suratDireksi
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
          }
        } else {
          final res = await api.suratDireksi
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
