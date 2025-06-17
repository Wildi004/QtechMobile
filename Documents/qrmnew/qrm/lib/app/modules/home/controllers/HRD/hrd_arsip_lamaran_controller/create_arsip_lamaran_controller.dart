import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/arsip_lamaran.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class CreateArsipLamaranController extends GetxController with Apis {
  final forms = LzForm.make([
    'nama',
    'image',
    'tgl_lamaran',
    'posisi',
    'lokasi_kantor',
    'status',
  ]);
  final status = [
    {'id': 1, 'province_id': 1, 'name': 'Interview'},
    {'id': 2, 'province_id': 1, 'name': 'Gagal Interview'},
    {'id': 3, 'province_id': 1, 'name': 'Lulus Interview'},
    {'id': 4, 'province_id': 1, 'name': 'Test'},
    {'id': 5, 'province_id': 1, 'name': 'Gagal Test'},
    {'id': 6, 'province_id': 1, 'name': 'Lulus Test'},
  ];
  File? file;
  RxString fileName = ''.obs;
  Rxn<ArsipLamaran> arsip = Rxn<ArsipLamaran>();
  Future<List<Map>> getStatus() async {
    await Future.delayed(const Duration(seconds: 1));
    return status;
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
          final res = await api.arsipLamaran
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? ' ');
          }
        } else {
          final res = await api.arsipLamaran
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message ?? ' ');
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
