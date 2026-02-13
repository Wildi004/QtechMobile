import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrm_dev/app/core/utils/config.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/karyawan_tetap/show%20dialog%20cetak/cetak_karyawan_view.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class CetakKaryawanController extends GetxController with Apis {
  final String baseUrl = AppConfig.baseUrl;

  /// Tampilkan dialog pilihan status karyawan
  Future<void> showStatusDialog() async {
    final statusList = ['tetap', 'kontrak', 'training', 'special'];

    String? selectedStatus = await showDialog<String>(
      context: Get.context!,
      builder: (context) {
        return CetakKaryawanView(statusList: statusList);
      },
    );

    if (selectedStatus != null) {
      debugPrint('[LOG] Status dipilih: $selectedStatus');
      await getDataCetak({'status_karyawan': selectedStatus});
    }
  }

  Future<void> getDataCetak(Map<String, dynamic> query) async {
    try {
      Get.dialog(
        const Center(child: CustomLoading()),
        barrierDismissible: false,
      );

      debugPrint('[LOG] Memanggil getDataCetak dengan query: $query');

      final uri = Uri.parse('$baseUrl/karyawan/tetap/cetak')
          .replace(queryParameters: query);

      debugPrint('[LOG] Request GET ke: $uri');

      final token = GetStorage().read('token') ?? '';

      final response = await HttpClient().getUrl(uri).then((req) {
        req.headers.set('Authorization', 'Bearer $token');
        req.headers.set('Accept', 'application/pdf');
        return req.close();
      });

      final statusCode = response.statusCode;
      debugPrint('[LOG] Status code: $statusCode');

      if (statusCode != 200) {
        final responseBody =
            await response.transform(SystemEncoding().decoder).join();
        debugPrint('[LOG] Gagal mendapatkan data. Status code: $statusCode');
        debugPrint('[LOG] Response body: $responseBody');

        if (Get.isDialogOpen ?? false) Get.back();

        Get.snackbar(
          'Maaf',
          'Tidak ada data yang ditemukan.',
          backgroundColor: const Color.fromARGB(255, 171, 81, 74),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        return;
      }

      final bytes = await consolidateHttpClientResponseBytes(response);

      if (bytes.isEmpty) {
        debugPrint('[LOG] File kosong atau tidak valid.');

        if (Get.isDialogOpen ?? false) Get.back();

        Get.snackbar(
          'Maaf',
          'Tidak ada data yang ditemukan.',
          backgroundColor: const Color.fromARGB(255, 171, 81, 74),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        return;
      }

      if (Get.isDialogOpen ?? false) Get.back();

      final dir = await getTemporaryDirectory();
      final filePath =
          '${dir.path}/karyawan_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File(filePath);

      await file.writeAsBytes(bytes, flush: true);

      // Buka file PDF
      final result = await OpenFilex.open(file.path);
      debugPrint('[LOG] OpenFilex result: ${result.message}');
    } catch (e) {
      debugPrint('[LOG] Terjadi error saat mengambil data cetak: $e');

      if (Get.isDialogOpen ?? false) Get.back();
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat mengambil data.',
        backgroundColor: const Color.fromARGB(255, 171, 81, 74),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
