import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class EditDataMandorController extends GetxController with Apis {
  RxString fileName = ''.obs;
  XFile? fileImage;
  File? file;

  final forms = LzForm.make([
    'nama',
    'alamat_ktp',
    'no_hp',
    'alamat_domisili',
    'ktp',
    'status',
    'harga',
    'ketepatan_waktu',
    'kualitas_pekerjaan',
    'kepatuhan_safety',
    'komunikasi',
    'spesialis',
    'files[]'
  ]);

  Future onSubmit([String? resourceId]) async {
    try {
      final form = forms.validate(required: ['*']);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;
        if (fileImage == null) {
          return Toast.show('File image dan ttd harus diisi');
        }
        payload['image'] = await api.toFile(fileImage!.path);

        if (resourceId == null) {
          final res = await api.dataMandor
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          final res = await api.dataMandor
              .updateData(payload, resourceId)
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
