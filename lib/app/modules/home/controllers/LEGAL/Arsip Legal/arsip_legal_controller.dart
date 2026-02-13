import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20legal/arsip_legal.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/arsiv/arsip_karyawan/file%20view/file_view.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:http/http.dart' as http;

class ArsipLegalController extends GetxController with Apis {
  final forms = LzForm.make([
    'id',
    'nama',
    'tgl_upload',
    'keterangan',
    'image',
    'created_at',
    'user_name'
  ]);

  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;
  final formDetails = <FormManager>[].obs;

  List<ArsipLegal> listArsip = [];
  RxList<ArsipLegal> arsip = <ArsipLegal>[].obs;
  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.arsipLegal.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listArsip = ArsipLegal.fromJsonList(res.data);
      arsip.value = listArsip;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteData(int id) async {
    try {
      final res =
          await api.arsipLegal.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listArsip.removeWhere((e) => e.id == id);
      isLoading.refresh();
      Get.snackbar('Berhasil', res.message ?? '');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void insertData(ArsipLegal data) {
    listArsip.insert(0, data);
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
      final res = await api.arsipLegal.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listArsip = ArsipLegal.fromJsonList(res.data);
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
    super.onInit();
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listArsip.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res =
          await api.arsipLegal.getData({...query, 'search': searchC.text});
      final data = ArsipLegal.fromJsonList(res.data);
      listArsip.addAll(data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      Utils.timer(() {
        isPaginate.value = false;
        isLoading.refresh();
      }, 1.s);
    }
  }

  Future<void> openFileWithTokenAndShowViewer(String fileUrl) async {
    try {
      Get.dialog(
        const CustomLoading(),
      );

      final token = await storage.read('token');
      if (token == null) {
        Get.back(); // Tutup dialog loading
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
          Get.back(); // Tutup dialog loading
          Toast.show('Format file tidak didukung untuk pratinjau');
          return;
        }

        Get.back(); // Tutup dialog loading SEBELUM pindah halaman
        Get.to(() => FileViewerPage(
              fileBytes: bytes,
              fileType: isPdf ? 'pdf' : 'image',
            ));
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
