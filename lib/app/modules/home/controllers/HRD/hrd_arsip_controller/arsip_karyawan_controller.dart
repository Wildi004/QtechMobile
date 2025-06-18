import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Bindings;
import 'package:lazyui/lazyui.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/arsip_karyawan_hrd/arsip_karyawan_hrd.dart';
import 'package:qrm/app/data/services/storage/storage.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class ArsipKaryawanController extends GetxController with Apis {
  var dataKaryawan = [].obs;
  var isLoading = true.obs;
  RxString searchQuery = "".obs;

  List<ArsipKaryawanHrd> listAK = [];
  RxList<ArsipKaryawanHrd> rxAK = <ArsipKaryawanHrd>[].obs;

  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  int page = 1, total = 0;

  Future getArsip() async {
    try {
      page = 1;
      isLoading.value = true;

      final res = await api.arsipKaryawanHrd.getData(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listAK = ArsipKaryawanHrd.fromJsonList(res.data);
      rxAK.value = listAK;
      logg('ini data daftar $res');
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> isImageFile(String url) async {
    try {
      final token = await storage.read('token');
      final response = await http.head(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final contentType = response.headers['content-type'] ?? '';
      return contentType.startsWith('image/');
    } catch (_) {
      return false;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    rxAK.value = listAK
        .where((data) =>
            data.name?.toLowerCase().contains(searchQuery.value) ?? false)
        .toList();
  }

  Future onPageInit() async {
    try {
      await getArsip();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    Bindings.onRendered(() {
      getArsip();
      // getArsipTimur();
    });
    super.onInit();
  }

  void insertData(ArsipKaryawanHrd data) {
    listAK.insert(0, data);
    isLoading.refresh();
  }

  Future<ImageProvider?> getImageWithToken(String imageUrl) async {
    try {
      final token = await storage.read('token');
      if (token == null) {
        Toast.show('Token tidak ditemukan');
        return null;
      }

      logg('Meminta gambar dari URL: $imageUrl');

      final response = await http.get(
        Uri.parse(imageUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      logg('Status kode respons: ${response.statusCode}');
      logg('Content-Type: ${response.headers['content-type']}');

      if (response.statusCode == 200) {
        final contentType = response.headers['content-type'] ?? '';
        if (!contentType.startsWith('image/')) {
          Toast.show('Bukan file gambar');
          return null;
        }

        return MemoryImage(response.bodyBytes);
      } else {
        Toast.show('Gagal mengambil gambar');
        return null;
      }
    } catch (e) {
      logg('Error saat mengambil gambar: $e');
      Toast.show('Terjadi kesalahan');
      return null;
    }
  }

  void updateData(ArsipKaryawanHrd data, int id) {
    try {
      int index = listAK.indexWhere((e) => e.userId == id);
      if (index >= 0) {
        listAK[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future<void> openFileWithToken(String fileUrl) async {
    try {
      final token = await storage.read('token');
      if (token == null) {
        Toast.show('Token tidak ditemukan');
        return;
      }

      final response = await http.get(
        Uri.parse(fileUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        String ext = p.extension(Uri.parse(fileUrl).path);
        if (ext.isEmpty || ext.length > 5) ext = '.bin';

        final hash = md5.convert(utf8.encode(fileUrl)).toString();
        final fileName = 'file_$hash$ext';

        final tempDir = await getTemporaryDirectory();
        final filePath = p.join(tempDir.path, fileName);
        final file = File(filePath);

        await file.writeAsBytes(bytes);

        logg('File disimpan di: $filePath');
        await OpenFilex.open(file.path);

      } else {
        Toast.show('Gagal mengunduh file. Status: ${response.statusCode}');
      }
    } catch (e) {
      logg('Gagal membuka file: $e');
      Toast.show('Terjadi kesalahan saat membuka file');
    }
  }

  Future deletet(int id) async {
    try {
      final res =
          await api.arsipKaryawanHrd.deleteData(id).ui.loading('Menghapus...');

      if (!res.status) {
        return Toast.error(res.message);
      }

      // Hapus dari listAK berdasarkan detail.id
      listAK.removeWhere((e) {
        final detailList =
            e.detail; // Jika kamu pakai model, misalnya List<Detail>
        return detailList?.any((d) => d.id == id) ?? false;
      });

      isLoading.refresh();

      Get.snackbar('Berhasil', res.message ?? '');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listAK.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.arsipKaryawanHrd.getData(query);

      final data = ArsipKaryawanHrd.fromJsonList(res.data);
      listAK.addAll(data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      Utils.timer(() {
        isPaginate.value = false;
        isLoading.refresh();
      }, 1.s);
    }
  }
}
