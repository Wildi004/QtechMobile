import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrm_dev/app/core/utils/config.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class PrintPembelianPpn extends GetxController {
  final String baseUrl = AppConfig.baseUrl;

  Future<void> cetakDelPoPpn(Map<String, dynamic> query) async {
    try {
      Get.dialog(
        const Center(child: CustomLoading()),
        barrierDismissible: false,
      );

      debugPrint('[LOG] 🔹 Memanggil cetakDelPoPpn dengan query: $query');

      final uri = Uri.parse('${baseUrl}logistik/pembelian/ppn/cetak')
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
        if (Get.isDialogOpen ?? false) Get.back();
        Get.snackbar(
          'Gagal',
          'Tidak ada data Delivery PO PPN yang ditemukan untuk filter ini.',
          backgroundColor: const Color.fromARGB(255, 171, 81, 74),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        return;
      }

      final bytes = await consolidateHttpClientResponseBytes(response);

      if (bytes.isEmpty) {
        if (Get.isDialogOpen ?? false) Get.back();
        Get.snackbar(
          'Gagal',
          'File PDF kosong atau tidak valid.',
          backgroundColor: const Color.fromARGB(255, 171, 81, 74),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 3),
        );
        return;
      }

      if (Get.isDialogOpen ?? false) Get.back();

      // 🔹 Buat folder sebelum menyimpan
      final dir = await getTemporaryDirectory();
      final deliveryDir = Directory('${dir.path}/delivery/po');
      if (!await deliveryDir.exists()) {
        await deliveryDir.create(recursive: true);
      }

      final filePath =
          '${deliveryDir.path}/ppn_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File(filePath);

      await file.writeAsBytes(bytes, flush: true);

      final result = await OpenFilex.open(file.path);
      debugPrint('[LOG] OpenFilex result: ${result.message}');
    } catch (e) {
      if (Get.isDialogOpen ?? false) Get.back();
      debugPrint('[LOG] Terjadi error saat mencetak Delivery PO PPN: $e');
      Get.snackbar(
        'Error',
        'Terjadi kesalahan saat mencetak Delivery PO PPN.',
        backgroundColor: const Color.fromARGB(255, 171, 81, 74),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
