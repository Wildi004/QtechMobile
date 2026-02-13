import 'dart:typed_data';
import 'package:fetchly/utils/log.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qrm_dev/app/data/services/storage/storage.dart';

enum ImageSlot { diri, ktp, kk, skck }

class ImageToken extends GetxController {
  // Legacy (biar kode lama tetap jalan)
  Rx<Uint8List?> imageBytes = Rx<Uint8List?>(null);

  // 4 slot baru
  final fotoDiriBytes = Rx<Uint8List?>(null);
  final fotoKtpBytes = Rx<Uint8List?>(null);
  final fotoKkBytes = Rx<Uint8List?>(null);
  final fotoSkckBytes = Rx<Uint8List?>(null);

  // Peta helper untuk akses dinamis
  Rx<Uint8List?> _rxFor(ImageSlot slot) {
    switch (slot) {
      case ImageSlot.diri:
        return fotoDiriBytes;
      case ImageSlot.ktp:
        return fotoKtpBytes;
      case ImageSlot.kk:
        return fotoKkBytes;
      case ImageSlot.skck:
        return fotoSkckBytes;
    }
  }

  /// Versi lama: kalau nggak kasih target, tulis ke `imageBytes`
  Future<void> loadImage(String url, {ImageSlot? target}) async {
    final token = await storage.read('token');

    try {
      logg('LOAD IMAGE URL: $url');
      final res = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      logg('IMG STATUS: ${res.statusCode}');
      if (res.statusCode == 200) {
        if (target == null) {
          imageBytes.value = res.bodyBytes; // kompatibel kode lama
        } else {
          _rxFor(target).value = res.bodyBytes; // tulis ke slot spesifik
        }
      } else {
        Get.snackbar('Error', 'Gagal memuat gambar (${res.statusCode})');
        if (target == null) {
          imageBytes.value = null;
        } else {
          _rxFor(target).value = null;
        }
      }
    } catch (e) {
      logg('LOAD IMAGE ERROR: $e');
      Get.snackbar('Error', 'Gagal memuat gambar');
      if (target == null) {
        imageBytes.value = null;
      } else {
        _rxFor(target).value = null;
      }
    }
  }
}
