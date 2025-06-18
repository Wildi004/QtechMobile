import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/services/storage/storage.dart';

class ImageFileToken extends GetxController {
  Rx<Uint8List?> imageBytes = Rx<Uint8List?>(null);

  Future<void> loadImage(String url) async {
    try {
      final response = await getWithToken(url);
      if (response.statusCode == 200) {
        imageBytes.value = response.bodyBytes;
      } else {
        logg('Gagal memuat gambar. Status: ${response.statusCode}');
      }
    } catch (e) {
      logg('Error loading image: $e');
    }
  }

  Future<http.Response> getWithToken(String url) async {
    try {
      final token = await storage.read('token');
      if (token == null) throw Exception('Token tidak tersedia');

      return await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
    } catch (e) {
      logg('Error getWithToken: $e');
      rethrow;
    }
  }

  RxMap<int, Uint8List?> imageMap = <int, Uint8List?>{}.obs;

  Future<void> loadImages(String url, int id) async {
    try {
      final response = await getWithToken(url);
      if (response.statusCode == 200) {
        imageMap[id] = response.bodyBytes;
      } else {
        logg('Gagal memuat gambar. Status: ${response.statusCode}');
      }
    } catch (e) {
      logg('Percobaan ulang setelah error pertama...');
      try {
        final retry = await getWithToken(url);
        if (retry.statusCode == 200) {
          imageMap[id] = retry.bodyBytes;
        } else {
          logg(
              'Gagal memuat gambar setelah retry. Status: ${retry.statusCode}');
        }
      } catch (err) {
        logg('Gagal total memuat gambar: $err');
      }
    }
  }

  Future<http.Response> getWithTokens(String url) async {
    final token = await storage.read('token');
    if (token == null) throw Exception('Token tidak tersedia');

    return await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }
}
