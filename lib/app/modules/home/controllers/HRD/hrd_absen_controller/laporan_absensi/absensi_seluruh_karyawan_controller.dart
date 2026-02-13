import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lazyui/lazyui.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrm_dev/app/core/utils/config.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/user.dart';
import 'package:http/http.dart' as http;

class AbsensiSeluruhKaryawanController extends GetxController with Apis {
  final RxString selectedItem = ''.obs;

  final TextEditingController dateController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  final RxString selectedUserId = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isSubmitting = false.obs;
  List<User> users = [];

  void setSelectedItem(String value) {
    selectedItem.value = value;
    dateController.clear();
    monthController.clear();
    yearController.clear();
    selectedUserId.value = '';
  }

  Future<void> getListUser() async {
    try {
      isLoading.value = true;
      final res = await api.user.getPageUser();
      users = User.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submit() async {
    // Validasi required
    if (selectedItem.value == 'satu' && dateController.text.isEmpty) {
      Toast.show('Tanggal wajib diisi');
      return;
    }
    if (selectedItem.value == 'dua' &&
        (monthController.text.isEmpty || yearController.text.isEmpty)) {
      Toast.show('Bulan dan Tahun wajib diisi');
      return;
    }
    if (selectedItem.value == 'tiga' && selectedUserId.value.isEmpty) {
      Toast.show('Karyawan wajib dipilih');
      return;
    }

    String? tanggal =
        dateController.text.isNotEmpty ? dateController.text : null;
    String? bulanTahun =
        (monthController.text.isNotEmpty && yearController.text.isNotEmpty)
            ? '${yearController.text}-${monthController.text}'
            : null;
    String? karyawan =
        selectedUserId.value.isNotEmpty ? selectedUserId.value : null;

    Map<String, dynamic> query = {};

    if (tanggal != null) query['tanggal'] = tanggal;
    if (bulanTahun != null) query['bulan-tahun'] = bulanTahun;
    if (karyawan != null) query['karyawan'] = karyawan;

    logg('🔍 Query: $query');

    try {
      isSubmitting.value = true;

      final uri = Uri.parse('${AppConfig.baseUrl}hrd/absensi/cetak').replace(
          queryParameters:
              query.map((key, value) => MapEntry(key, value.toString())));

      final token = GetStorage().read('token') ?? '';

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/pdf',
        },
      );

      logg('📥 Response code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        if (bytes.isEmpty) {
          Get.snackbar('Error', 'File kosong / tidak valid');
          return;
        }

        final dir = await getTemporaryDirectory();
        final filePath =
            '${dir.path}/absensi_${DateTime.now().millisecondsSinceEpoch}.pdf';
        final file = File(filePath);

        await file.writeAsBytes(bytes, flush: true);

        final result = await OpenFilex.open(file.path);
        logg('📂 OpenFilex result: ${result.message}');
      } else {
        // Coba ambil pesan dari body kalau ada
        final message =
            response.body.isNotEmpty ? response.body : 'Gagal request';
        Get.snackbar('Error', 'Status: ${response.statusCode}\n$message');
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isSubmitting.value = false;
    }
  }
}
