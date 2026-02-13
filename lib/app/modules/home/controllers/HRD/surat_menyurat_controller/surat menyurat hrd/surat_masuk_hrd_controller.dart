import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/surat_masuk/surat_masuk.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:open_filex/open_filex.dart';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';

class SuratMasukHrdController extends GetxController with Apis {
  RxString searchQuery = "".obs;
  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
  List<SuratMasuk> listSurat = [];
  RxList<SuratMasuk> surat = <SuratMasuk>[].obs;
  int page = 1, total = 0;
  RxBool isPaginate = false.obs;
  final forms = LzForm.make([
    'perihal',
    'tgl_surat',
    'sifat',
    'image',
    'keterangan',
    'dep_id',
  ]);

  late String depId;

  Map<String, dynamic> get query => {
        'page': page,
        'per_page': 10,
      };

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;

      final res = await api.suratMasuk.getData(depId, query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listSurat = SuratMasuk.fromJsonList(res.data);
      surat.value = listSurat;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> openFileWithDownload(String fileUrl) async {
    try {
      final token = await storage.read('token');
      if (token == null) {
        Toast.show('Token tidak ditemukan');
        return;
      }
      logg('ini token : $token');
      logg('Original URL: $fileUrl');

      final response = await http.get(
        Uri.parse(fileUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      logg('Status Code: ${response.statusCode}');

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

        final result = await OpenFilex.open(file.path);
        logg('OpenFilex result: $result');
      } else {
        Toast.show('Gagal mengunduh file. Status: ${response.statusCode}');
      }
    } catch (e) {
      logg('Gagal unduh/open file: $e');
      Toast.show('Terjadi kesalahan: $e');
    }
  }

  Future onPaginate() async {
    try {
      if (listSurat.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;

      final res = await api.suratMasuk.getData(depId, query);
      final data = SuratMasuk.fromJsonList(res.data);

      listSurat.addAll(data);
      surat.value = listSurat;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      Utils.timer(() {
        isPaginate.value = false;
        isLoading.refresh();
      }, 1.s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    surat.value = listSurat
        .where((data) =>
            data.userPenerima?.toLowerCase().contains(searchQuery.value) ??
            false)
        .toList();
  }

  Future onPageInit() async {
    try {
      await getData();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void insertData(SuratMasuk data) {
    listSurat.insert(0, data);
    surat.insert(0, data);
    isLoading.refresh();
  }

  @override
  void onInit() {
    super.onInit();

    depId = '23';
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }
}
