import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/karyawan_tidak.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class FormKttController extends GetxController with Apis {
  final forms = LzForm.make([
    'id', //
    'nik', //
    'name', //
    'no_telp', //
    'foto', //
    'role_id',
    'dep_id',
    'regional', //
    'alamat_ktp', //
    'alamat_domisili', //
    'tgl_lahir', //
    'tempat_lahir', //
    'gender', //
    'agama', //
    'status_kawin_id', //
    'status_proyek', //
    'proyek_item_id', //
    'tgl_bergabung', //
    'is_active',
    'date_created',
    'role', //
    'dept', //
  ]);
  File? file;
  RxString fileName = ''.obs;
  List<KaryawanTidak> listkaryawan = [];

  Rxn<KaryawanTidak> rxKar = Rxn<KaryawanTidak>();
  RxList<KaryawanTidak> karyawan = <KaryawanTidak>[].obs;
  RxBool isLoading = true.obs;

  void updateData(KaryawanTidak data, int id) {
    try {
      int index = listkaryawan.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listkaryawan[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*']);

      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;

        if (file != null) {
          payload['image'] = await api.toFile(file!.path);
        }

        if (id == null) {
          final res = await api.karyawanTidak
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
          }
        } else {
          final res = await api.karyawanTidak
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
