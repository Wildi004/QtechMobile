import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/arsip_perusahaan.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class CreateArsipPerusahaanController extends GetxController with Apis {
  final forms = LzForm.make([
    'nama',
    'image',
    'tgl_upload',
    'expired_date',
    'tgl_berlaku_dok',
    'keterangan'
  ]);
  File? file;
  RxString fileName = ''.obs;
  XFile? fileImage;
  Rxn<ArsipPerusahaan> aset = Rxn<ArsipPerusahaan>();

  Future onSubmit([int? id]) async {
    try {
      final required = [
        '*',
      ];

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
          final res = await api.arsipPerusahaan
              .createData(payload)
              .ui
              .loading('Menambahkan...');

          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          } else {}
        } else {}
      } else {}
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
