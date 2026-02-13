import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Bindings;
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/arsip_karyawan_hrd/arsip_karyawan_hrd.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/arsip_karyawan_hrd/detail.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/arsiv/arsip_karyawan/file%20view/file_view.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class ArsipKaryawanController extends GetxController with Apis {
  var dataKaryawan = [].obs;
  var isLoading = true.obs;
  RxString searchQuery = "".obs;
  var tabIndex = 0.obs;

  List<ArsipKaryawanHrd> listAK = [];
  RxList<ArsipKaryawanHrd> rxAK = <ArsipKaryawanHrd>[].obs;

  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  int page = 1, total = 0;
  final details = <ArsivKaryawanDetail>[].obs;
  Future<void> getDetails(int id) async {
    try {
      final res = await api.arsipKaryawanHrd.getDataDetail(id);

      final detailList = res.data['detail'];

      details.value = ArsivKaryawanDetail.fromJsonList(detailList);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

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

  RxBool isSearching = false.obs;
  RxBool isPaginateSearch = false.obs;
  String keyword = '';
  TextEditingController searchC = TextEditingController();

  Future updateSearchQuery(String value) async {
    try {
      page = 1;
      isLoading.value = true;
      final res =
          await api.arsipKaryawanHrd.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listAK = ArsipKaryawanHrd.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
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
      if (Get.arguments is ArsipKaryawanHrd) {
        final arsip = Get.arguments as ArsipKaryawanHrd;

        detailsArsip.value = arsip.detail ?? [];
      }
    });
    super.onInit();
  }

  void insertData(ArsivKaryawanDetail data) {
    detailsArsip.insert(0, data);
    isLoading.refresh();
  }

  void updateData(ArsivKaryawanDetail data, int? id) {
    int index = detailsArsip.indexWhere((e) => e.id == id);

    if (index != -1) {
      detailsArsip[index] = data;
      isLoading.refresh();
    }
  }

  Future<void> openFileWithTokenAndShowViewer(String fileUrl) async {
    try {
      logg(
        '--- MULAI openFileWithTokenAndShowViewer ---',
      );

      Get.dialog(const CustomLoading(), barrierDismissible: false);

      final token = await storage.read('token');
      logg(
        'Token: ${token != null ? "ADA" : "TIDAK ADA"}',
      );

      if (token == null) {
        Get.back();
        Toast.show('Token tidak ditemukan');
        return;
      }

      final uri = Uri.parse(fileUrl);
      logg('Request ke URL: $uri');

      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      logg(
        'Status Code: ${response.statusCode}',
      );
      logg(
        'Content-Type: ${response.headers['content-type']}',
      );
      logg(
        'Response size: ${response.bodyBytes.length} bytes',
      );

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        final contentType = response.headers['content-type'] ?? '';
        final isPdf = contentType.contains('application/pdf');
        final isImage = contentType.contains('image/');

        logg(
          'isPdf: $isPdf | isImage: $isImage',
        );

        if (!isPdf && !isImage) {
          Get.back();
          Toast.show('Format file tidak didukung untuk pratinjau');
          return;
        }

        Get.back();
        logg(
          'Navigasi ke FileViewerPage',
        );
        Get.to(() => FileViewerPage(
              fileBytes: bytes,
              fileType: isPdf ? 'pdf' : 'image',
            ));
      } else {
        Get.back();
        logg(
          'Gagal download. Status: ${response.statusCode}',
        );
        Toast.show('Gagal mengunduh file. Status: ${response.statusCode}');
      }
    } catch (e, stack) {
      Get.back();
      logg(
        '[EXCEPTION] $e',
      );
      logg(
        stack,
      );
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

      Toast.success(res.message);
      detailsArsip.removeWhere((e) => e.id == id);
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
      final res = await api.arsipKaryawanHrd
          .getData({...query, 'search': searchC.text});

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

  // tampung detailsnya di sini
  RxList<ArsivKaryawanDetail> detailsArsip = RxList([]);
}

// Future<bool> isImageFile(String url) async {
//   try {
//     final token = await storage.read('token');
//     final response = await http.head(
//       Uri.parse(url),
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );

//     final contentType = response.headers['content-type'] ?? '';
//     return contentType.startsWith('image/');
//   } catch (_) {
//     return false;
//   }
// }

// Future<ImageProvider?> getImageWithToken(String imageUrl) async {
//     try {
//       final token = await storage.read('token');
//       if (token == null) {
//         Toast.show('Token tidak ditemukan');
//         return null;
//       }

//       logg('Meminta gambar dari URL: $imageUrl');

//       final response = await http.get(
//         Uri.parse(imageUrl),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );

//       logg('Status kode respons: ${response.statusCode}');
//       logg('Content-Type: ${response.headers['content-type']}');

//       if (response.statusCode == 200) {
//         final contentType = response.headers['content-type'] ?? '';
//         if (!contentType.startsWith('image/')) {
//           Toast.show('Bukan file gambar');
//           return null;
//         }

//         return MemoryImage(response.bodyBytes);
//       } else {
//         Toast.show('Gagal mengambil gambar');
//         return null;
//       }
//     } catch (e) {
//       logg('Error saat mengambil gambar: $e');
//       Toast.show('Terjadi kesalahan');
//       return null;
//     }
//   }
