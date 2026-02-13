import 'dart:typed_data';
import 'package:fetchly/utils/log.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qrm_dev/app/data/services/storage/storage.dart';

class ImageFileTokenController extends GetxController {
  final imageBytes = Rx<Uint8List?>(null);

  final fotoDiriBytes = Rx<Uint8List?>(null);
  final fotoKtpBytes = Rx<Uint8List?>(null);
  final fotoKkBytes = Rx<Uint8List?>(null);
  final fotoSkckBytes = Rx<Uint8List?>(null);

  Future<void> loadImage(String url) async {
    logg('Mulai loadImage dengan URL: $url');
    
    imageBytes.value = await _fetch(url);
    if (imageBytes.value != null) {
      logg('loadImage berhasil, data bytes: ${imageBytes.value!.length} bytes');
    } else {
      logg('loadImage gagal, tidak ada data bytes yang diterima');
    }
  }

  Future<void> loadFotoDiri(String url) async {
    logg('Mulai loadFotoDiri dengan URL: $url');
    fotoDiriBytes.value = await _fetch(url);
    if (fotoDiriBytes.value != null) {
      logg(
          'loadFotoDiri berhasil, data bytes: ${fotoDiriBytes.value!.length} bytes');
    } else {
      logg('loadFotoDiri gagal, tidak ada data bytes yang diterima');
    }
  }

  Future<void> loadFotoKtp(String url) async {
    logg('Mulai loadFotoKtp dengan URL: $url');
    fotoKtpBytes.value = await _fetch(url);
    if (fotoKtpBytes.value != null) {
      logg(
          'loadFotoKtp berhasil, data bytes: ${fotoKtpBytes.value!.length} bytes');
    } else {
      logg('loadFotoKtp gagal, tidak ada data bytes yang diterima');
    }
  }

  Future<void> loadFotoKk(String url) async {
    logg('Mulai loadFotoKk dengan URL: $url');
    fotoKkBytes.value = await _fetch(url);
    if (fotoKkBytes.value != null) {
      logg(
          'loadFotoKk berhasil, data bytes: ${fotoKkBytes.value!.length} bytes');
    } else {
      logg('loadFotoKk gagal, tidak ada data bytes yang diterima');
    }
  }

  Future<void> loadFotoSkck(String url) async {
    logg('Mulai loadFotoSkck dengan URL: $url');
    fotoSkckBytes.value = await _fetch(url);
    if (fotoSkckBytes.value != null) {
      logg(
          'loadFotoSkck berhasil, data bytes: ${fotoSkckBytes.value!.length} bytes');
    } else {
      logg('loadFotoSkck gagal, tidak ada data bytes yang diterima');
    }
  }

  Future<Uint8List?> _fetch(String url) async {
    try {
      final token = await storage.read('token');
      logg(
          'Mengambil gambar dari URL: $url dengan token: ${token?.substring(0, 10)}...'); // partial token log
      final res = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      logg(token);
      logg('Response status code: ${res.statusCode}');
      if (res.statusCode == 200) {
        logg(
            'Berhasil mendapatkan gambar, size: ${res.bodyBytes.length} bytes');
        return res.bodyBytes;
      }
      Get.snackbar('Error', 'Gagal memuat gambar (${res.statusCode})');
      logg('Gagal mendapatkan gambar, status code: ${res.statusCode}');
      return null;
    } catch (e, stack) {
      logg('LOAD IMAGE ERROR: $e\nStackTrace: $stack');
      Get.snackbar('Error', 'Gagal memuat gambar');
      return null;
    }
  }
}
