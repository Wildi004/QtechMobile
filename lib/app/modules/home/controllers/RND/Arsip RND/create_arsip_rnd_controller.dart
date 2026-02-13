import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20rnd/arsip_rnd.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class CreateArsipRndController extends GetxController with Apis {
  final forms = LzForm.make(['nama', 'keterangan', 'image']);
  File? file;
  RxString fileName = ''.obs;
  Rxn<ArsipRnd> arsip = Rxn<ArsipRnd>();
  RxBool isLoading = true.obs;

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;
        if (file != null) {
          final imageFile = await api.toFile(file!.path);
          logg('[DEBUG] Image Multipart: $imageFile');
          payload['image'] = imageFile;
        }

        if (id == null) {
          final res = await api.arsipRnd
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          final res = await api.arsipRnd
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
