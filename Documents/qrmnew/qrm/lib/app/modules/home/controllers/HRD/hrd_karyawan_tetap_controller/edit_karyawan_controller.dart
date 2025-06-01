import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/karyawan_tetap.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

import 'karyawan_tetap_controller.dart';

class EditKaryawanController extends GetxController with Apis {
  final forms = LzForm.make([
    "id",
    "name",
    "no_induk",
    "golongan",
    "prosentase",
    "no_ktp",
    "email",
    "no_telp",
    "image",
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
    "agama",
    "status_kawin_id",
    "tgl_bergabung",
    "is_active",
    "is_online",
    "shift_id",
    "building_id",
    "ttd",
    "status_karyawan",
    "date_created",
    "id_telegram",
    "role",
    "dept",
    "shift",
    "building",
    'image',
    'ttd'
  ]);
  File? file;
  RxString fileName = ''.obs;
  List<KaryawanTetap> listkaryawan = [];
  final jabatanLabel = 'Jabatan'.obs;

  Rxn<KaryawanTetap> rxKar = Rxn<KaryawanTetap>();
  RxList<KaryawanTetap> karyawan = <KaryawanTetap>[].obs;
  RxBool isLoading = true.obs;
  RxList<FormManager> roleid = RxList<FormManager>();
  List<Map<String, dynamic>> roles = [];

  @override
  void onInit() {
    super.onInit();

     
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchRoles();
    });

    roleid.add(LzForm.make(['role_id']));
  }

Future<void> fetchRoles() async {
  final res = await api.role.getData().ui.loading();
  roles = List<Map<String, dynamic>>.from(res.data ?? []);

  if (roles.isNotEmpty) {
    // Pastikan key label dan value benar
    roleid[0].set('role_id', '').options(
      roles
          .where((e) => e['role'] != null && e['id'] != null) // filter valid data
          .map((e) => {
                'label': e['role'].toString(), // key label harus 'label'
                'value': e['id'].toString(),   // key value harus 'value'
              })
          .toList(),
    );
  } else {
    // Jika kosong, set options kosong agar tidak error
    roleid[0].set('role_id', '').options([]);
  }
}

  void updateData(KaryawanTetap data, int id) {
    try {
      int index = listkaryawan.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listkaryawan[index] = data;

        // update RxList juga
        karyawan[index] = data;

        // Trigger refresh tampilan
        karyawan.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*', 'image', 'ttd']);

      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;
        final role = roleid
            .map((e) => int.tryParse(e.extra('role_id').toString()))
            .where((e) => e != null)
            .map((e) => e!)
            .first;
        payload['role_id'] = role;

        payload['user_id'] = auth.id;

        if (id == null) {
          final res = await api.karyawanTetap
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Toast.success('Data berhasil ditambahkan, silahkan refresh');
          }
        } else {
          final res = await api.karyawanTetap
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Toast.success('Data berhasil diperbarui, silahkan refresh');
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future openRole(int index) async {
  try {
    if (index >= roleid.length) {
      roleid.add(LzForm.make(['role_id']));
    }

    if (roles.isEmpty) {
      final res = await api.role.getData().ui.loading();
      roles = List<Map<String, dynamic>>.from(res.data ?? []);
    }

    roleid[index].set('role_id', '').options(
      roles
          .where((e) => e['role'] != null && e['id'] != null)
          .map((e) => {
                'label': e['role'].toString(),
                'value': e['id'].toString(),
              })
          .toList(),
    );
  } catch (e, s) {
    Errors.check(e, s);
  }
}


  Future onSubmitTtd([int? id]) async {
    try {
      final form = forms.validate(required: ['ttd']);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;

        if (file != null) {
          payload['ttd'] = await api.toFile(file!.path);
        }

        if (id == null) {
          final res = await api.karyawanTetap
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Toast.success('data berhasil ditambahkan');
          }
        } else {
          final res = await api.karyawanTetap
              .updateTtd(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Toast.success('Data berhasil diperbarui, silahkan refresh');
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future deletetdkn(int id) async {
    try {
      final res =
          await api.karyawanTetap.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listkaryawan.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Toast.success('Data berhasil dihapus');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
