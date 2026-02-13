import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/daftar_tkdn.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class FormTkdnController extends GetxController with Apis {
  final forms = LzForm.make([
    'nama',
    'tgl_upload',
    'image',
  ]);
  File? file;
  RxString fileName = ''.obs;
  Rxn<DaftarTkdn> tkdn = Rxn<DaftarTkdn>();

  Future onSubmit([int? id]) async {
    try {
      final required = ['*', 'image'];
      if (id == null) {
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

        // 🔹 Proses simpan
        if (id == null) {
          // ➕ Tambah data baru
          final res = await api.daftarTkdn
              .createData(payload)
              .ui
              .loading('Menambahkan...');

          if (res.status) {
            Get.back(result: res.data);
            Toast.success('Berhasil menambahkan data TKDN');
          }
        } else {
          // ✏️ Edit data
          final res = await api.daftarTkdn
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');

          if (res.status) {
            Get.back(result: res.data);
            Toast.success('Berhasil memperbarui data TKDN');
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
