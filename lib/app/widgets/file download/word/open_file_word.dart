import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class OpenFileWord {
  static Future<void> openWordFile({
    required String fileUrl,
    required Future<String?> Function() getToken,
  }) async {
    try {
      Get.dialog(const CustomLoading(), barrierDismissible: false);

      final token = await getToken();
      if (token == null) {
        Get.back();
        Toast.show('Token tidak ditemukan');
        return;
      }

      final uri = Uri.parse(fileUrl);
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final filePath = '${dir.path}/temp.docx';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        Get.back();
        await OpenFilex.open(filePath);
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
