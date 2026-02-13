import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/departemen.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class CreateDevController extends GetxController with Apis {
  final forms = LzForm.make([
    'departemen',
  ]);
  File? file;
  RxString fileName = ''.obs;
  Rxn<Departemen> departemen = Rxn<Departemen>();

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: [
        '*',
      ]);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;

        if (id == null) {
          final res = await api.departemen
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message.toString());
          }
        } else {
          final res = await api.departemen
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

  List<Map<String, dynamic>> company = [];

  RxList<FormManager> members = RxList([]);

  Future openComapny(int index) async {
    try {
      if (company.isEmpty) {
        final res = await api.user.getListUser().ui.loading();
        company = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      members[index].set('user_id').options(company.labelValue('name', 'id'));
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
