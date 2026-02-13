import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/kategori_aset.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class FormKategoriAsetController extends GetxController with Apis {
  final forms = LzForm.make([
    'nama_kategori',
  ]);
  File? file;
  RxString fileName = ''.obs;
  Rxn<KategoriAset> data = Rxn<KategoriAset>();
  void resetForm() {
    forms.set('nama_kategori', '');
  }

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['satuan']);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;

        if (id == null) {
          final res = await api.kategoriAset
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message.toString());
          }
        } else {
          final res = await api.kategoriAset
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
