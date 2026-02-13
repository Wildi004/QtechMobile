import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/surat eksternal/surat_eksternal.dart';

class CreateSuratEksternalController extends GetxController with Apis {
  SuratEksternal? created;

  final forms = LzForm.make(['data', 'no_surat', 'tgl', 'keperluan']);
  RxBool isLoading = true.obs;

  /// Fetch nomor surat dari API
  Future<void> createSurat() async {
    try {
      isLoading.value = true;

      final res = await api.suratEksternal.created();

      // Karena response data = String (nomor surat)
      forms.fill({
        'data': res.data,
        'no_surat': res.data,
      });
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  /// Submit data surat eksternal
  Future<void> onSubmit([int? id]) async {
    try {
      // validasi field yang wajib diisi
      final required = ['no_surat', 'tgl', 'keperluan'];
      final form = forms.validate(required: required);

      if (form.ok) {
        final payload = form.value;

        // pastikan nomor surat diambil dari field 'data'
        payload['no_surat'] = forms.get('data');

        if (id == null) {
          // mode tambah
          final res = await api.suratEksternal
              .createData(payload)
              .ui
              .loading('Menyimpan data...');

          if (res.status) {
            Get.back(result: res.data);
            Toast.success('Surat eksternal berhasil dibuat');
          } else {
            Toast.warning(res.message ?? 'Gagal menambahkan surat');
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    createSurat();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }
}
