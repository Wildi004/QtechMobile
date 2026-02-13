import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20rnd/arsip_rnd.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/arsiv/arsip_karyawan/file%20view/file_view.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:http/http.dart' as http;
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class ArsipRndController extends GetxController with Apis {
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
  RxInt tab = 0.obs;

  List<ArsipRnd> listArsip = [];
  RxList<ArsipRnd> arsip = <ArsipRnd>[].obs;
  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      ListItemAnimasi.animatedItems.clear();

      page = 1;
      isLoading.value = true;
      final res = await api.arsipRnd.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listArsip = ArsipRnd.fromJsonList(res.data);
      arsip.value = listArsip;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteData(int id) async {
    try {
      final res = await api.arsipRnd.deleteData(id).ui.loading('Menghapus...');
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

  void insertData(ArsipRnd data) {
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
      final res = await api.arsipRnd.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listArsip = ArsipRnd.fromJsonList(res.data);
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
          await api.arsipRnd.getData({...query, 'search': searchC.text});
      final data = ArsipRnd.fromJsonList(res.data);
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
      logg('[START] openFileWithTokenAndShowViewer');
      logg('[URL] $fileUrl');

      Get.dialog(
        const CustomLoading(),
      );

      final token = await storage.read('token');
      logg('[TOKEN] $token');

      if (token == null) {
        Get.back(); // Tutup dialog loading
        Toast.show('Token tidak ditemukan');
        logg('[ERROR] Token tidak ditemukan');
        return;
      }

      final uri = Uri.parse(fileUrl);
      logg('[REQUEST] GET $uri');

      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      logg('[RESPONSE] Status Code: ${response.statusCode}');
      logg('[RESPONSE] Headers: ${response.headers}');
      logg('[RESPONSE] Content-Length: ${response.contentLength}');
      logg('[RESPONSE] Content-Type: ${response.headers['content-type']}');

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        logg('[BYTES] File size: ${bytes.length} bytes');

        final contentType = response.headers['content-type'] ?? '';
        final isPdf = contentType.contains('application/pdf');
        final isImage = contentType.contains('image/');

        logg('[CHECK] isPdf=$isPdf, isImage=$isImage');

        if (!isPdf && !isImage) {
          Get.back();
          Toast.show('Format file tidak didukung untuk pratinjau');
          logg('[ERROR] Format file tidak didukung');
          return;
        }

        Get.back(); // Tutup dialog loading SEBELUM pindah halaman
        logg('[NAVIGATE] Ke FileViewerPage, type: ${isPdf ? 'pdf' : 'image'}');

        Get.to(() => FileViewerPage(
              fileBytes: bytes,
              fileType: isPdf ? 'pdf' : 'image',
            ));
      } else {
        Get.back();
        Toast.show('Gagal mengunduh file. Status: ${response.statusCode}');
        logg('[ERROR] Gagal mengunduh file. Status: ${response.statusCode}');
      }
    } catch (e, st) {
      Get.back();
      Toast.show('Terjadi kesalahan saat membuka file');
      logg('[EXCEPTION] $e');
      logg('[STACKTRACE] $st');
    }
  }
}
