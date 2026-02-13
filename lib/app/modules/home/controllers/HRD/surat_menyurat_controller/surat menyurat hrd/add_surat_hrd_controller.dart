import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/departemen.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';

class AddSuratHrdController extends GetxController with Apis {
  final forms = LzForm.make(
      ['perihal', 'tgl_surat', 'sifat', 'image', 'keterangan', 'dept_id']);
  File? file;
  RxString fileName = ''.obs;

  RxList<Departemen> departemenList = <Departemen>[].obs;
  RxList<int> selectedDepIds = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    getDepartemen();
  }

  Future getDepartemen() async {
    try {
      final res = await api.departemen.getData({'limit': 'all'});
      departemenList.value = Departemen.fromJsonList(res.body['data']);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future<List<Map>> getSifat() async {
    await Future.delayed(const Duration(seconds: 1));
    return sifat;
  }

  final sifat = [
    {'name': 'Biasa'},
    {'name': 'Penting'},
    {'name': 'Rahasia'},
  ];

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['perihal']);

      logg('Selected dep_ids: $selectedDepIds');
      if (selectedDepIds.isEmpty) {
        Toast.show('Pilih departemen dulu');
        return;
      }

      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;
        payload['dep_id[]'] = selectedDepIds;

        if (file != null) {
          payload['image'] = await api.toFile(file!.path);
        }

        if (id == null) {
          final res = await api.suratMasuk
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message.toString());
          }
        } else {
          final res = await api.suratMasuk
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
