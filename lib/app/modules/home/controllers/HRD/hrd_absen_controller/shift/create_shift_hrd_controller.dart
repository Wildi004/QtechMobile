import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/shift_building/shift.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class CreateShiftHrdController extends GetxController with Apis {
  final forms = LzForm.make(['shift_name', 'time_in', 'time_out']);
  File? file;
  RxString fileName = ''.obs;
  Rxn<Shifts> shift = Rxn<Shifts>();
  RxBool isLoading = true.obs;

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;
        logg('payload $payload');
        payload['user_id'] = auth.id;

        if (id == null) {
          final res =
              await api.shift.createData(payload).ui.loading('Menambahkan...');
          if (res.status) {
            logg('status $res');
            Get.back(result: res.data);
            // Get.snackbar('Berhasil', res.message ?? '',
            //     duration: Duration(seconds: 1));
            Get.closeAllSnackbars(); // tutup snackbar lama
            Get.snackbar('Berhasil', res.message ?? '');
          }
        } else {
          final res = await api.shift
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
