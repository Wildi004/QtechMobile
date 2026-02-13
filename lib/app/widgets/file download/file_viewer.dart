import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class FileHelper {
  static Future<void> openFileWithTokenAndShowViewer({
    required String fileUrl,
    required Future<String?> Function() getToken,
    required Widget Function(Uint8List fileBytes, String fileType) viewerPage,
  }) async {
    try {
      Get.dialog(
        const CustomLoading(),
        barrierDismissible: false,
      );

      final token = await getToken();
      if (token == null) {
        Get.back();
        Toast.show('Token tidak ditemukan');
        return;
      }

      final uri = Uri.parse(fileUrl);
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        final contentType = response.headers['content-type'] ?? '';
        final isPdf = contentType.contains('application/pdf');
        final isImage = contentType.contains('image/');

        if (!isPdf && !isImage) {
          Get.back();
          Toast.show('Format file tidak didukung untuk pratinjau');
          return;
        }

        Get.back();
        Get.to(() => viewerPage(bytes, isPdf ? 'pdf' : 'image'));
      } else {
        Get.back();
        Toast.show('Gagal mengunduh file. Status: ${response.statusCode}');
      }
    } catch (e) {
      Get.back();
      Toast.show('Terjadi kesalahan saat membuka file');
      logg('[EXCEPTION] $e');
    }
  }
}
