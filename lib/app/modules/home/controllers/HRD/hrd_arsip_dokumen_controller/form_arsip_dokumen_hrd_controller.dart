import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/dokumen_hrd.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class FormArsipDokumenHrdController extends GetxController with Apis {
  final forms = LzForm.make([
    'nama',
    'image',
    'keterangan',
  ]);

  File? file;
  RxString fileName = ''.obs;
  Rxn<DokumenHrd> dokumen = Rxn<DokumenHrd>();

  Future onSubmit([int? id]) async {
    try {
      final required = ['*', 'image'];
      if (id != null) {
        required.add('image');
      }
      final form = forms.validate(required: required);

      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;

        if (file != null) {
          payload['image'] = await api.toFile(file!.path);
        } else {
          payload.remove('image');
        }

        if (id == null) {
          final res = await api.dokumenHrd
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          final res = await api.dokumenHrd
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
