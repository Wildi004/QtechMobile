import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/karyawan_tetap.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class FormKaryawanTetapController extends GetxController with Apis {
  final forms = LzForm.make([
    "id",
    "name",
    "no_induk",
    "golongan",
    "prosentase",
    "no_ktp",
    "email",
    "no_telp",
    "password",
    "role_id",
    "dept_id",
    "regional",
    "regional_ktp",
    "alamat_ktp",
    "alamat_domisili",
    "tempat_lahir",
    "tgl_lahir",
    "gender",
    'ttd',
    "agama",
    "status_kawin_id",
    "tgl_bergabung",
    "is_active",
    "is_online",
    "shift_id",
    "building_id",
    "status_karyawan",
    "date_created",
    "id_telegram",
    "role",
    "dept",
    "shift",
    "building",
  ]);
  File? file;
  RxString fileName = ''.obs;
  List<KaryawanTetap> listkaryawan = [];

  Rxn<KaryawanTetap> rxKar = Rxn<KaryawanTetap>();
  RxList<KaryawanTetap> karyawan = <KaryawanTetap>[].obs;
  RxBool isLoading = true.obs;

  void updateData(KaryawanTetap data, int id) {
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

  Future getData() async {
    try {
      isLoading.value = true;
      final res = await api.karyawanTetap.getData();

      listkaryawan = KaryawanTetap.fromJsonList(res.data);

      karyawan.value = listkaryawan;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void insertData(KaryawanTetap data) {
    listkaryawan.insert(0, data);
    isLoading.refresh();
  }

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: [
        '*',
      ]);

      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;

        if (file != null) {
          payload['image'] = await api.toFile(file!.path);
        }

        if (id == null) {
          final res = await api.karyawanTetap
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
          }
        } else {
          final res = await api.karyawanTetap
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

  Future deleteUser(int id) async {
    try {
      final res =
          await api.karyawanTetap.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listkaryawan.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Get.snackbar('Berhasil', res.message.toString());
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
