import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/dokumen_hrd.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:http/http.dart' as http;

class ArsipDokumenHrdController extends GetxController with Apis {
  var tabIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;

  final forms = LzForm.make([
    'id',
    'nama',
    'tgl_upload',
    'keterangan',
    'image',
    'user_id',
    'created_at',
    'user_name',
  ]);

  var isExpanded = false.obs;
  List<DokumenHrd> listDoc = [];
  RxList<DokumenHrd> arsip = <DokumenHrd>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.dokumenHrd.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listDoc = DokumenHrd.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future delete(int id) async {
    try {
      final res =
          await api.dokumenHrd.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listDoc.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Get.snackbar('Berhasil', res.message ?? '');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void insertData(DokumenHrd data) {
    listDoc.insert(0, data);
    isLoading.refresh();
  }

  RxBool isSearching = false.obs;
  RxBool isPaginateSearch = false.obs;
  String keyword = '';
  TextEditingController searchC = TextEditingController();

  Future updateSearchQuery(String value) async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.dokumenHrd.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listDoc = DokumenHrd.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future onPageInit() async {
    try {
      await getData();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void updateData(DokumenHrd data, int id) {
    try {
      int index = listDoc.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listDoc[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future<void> openFileWithTokenAndShowViewer(String fileUrl) async {
    try {
      Get.dialog(const CustomLoading(), barrierDismissible: false);

      final token = await storage.read('token');
      if (token == null) {
        Get.back();
        Toast.show('Token tidak ditemukan');
        return;
      }

      final uri = Uri.parse(fileUrl);
      final response =
          await http.get(uri, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        final contentType = response.headers['content-type'] ?? '';

        // Simpan file ke temporary directory
        final dir = await getTemporaryDirectory();
        final extension = contentType.split('/').last.split(';').first;
        final filePath = '${dir.path}/tempfile.$extension';
        final file = File(filePath);
        await file.writeAsBytes(bytes);

        Get.back(); // tutup loading

        final result = await OpenFilex.open(filePath);
        logg('OpenFile result: $result');
      } else {
        Get.back();
        Toast.show('Gagal mengunduh file. Status: ${response.statusCode}');
      }
    } catch (e, s) {
      logg('Error membuka file: $e\n$s');
      Get.back();
      Toast.show('Terjadi kesalahan saat membuka file');
    }
  }

  Future onPaginate() async {
    try {
      if (listDoc.length >= total || isPaginate.value) {
        return;
      }
      page++;
      isPaginate.value = true;
      final res =
          await api.dokumenHrd.getData({...query, 'search': searchC.text});
      final data = DokumenHrd.fromJsonList(res.data);
      listDoc.addAll(data);
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
