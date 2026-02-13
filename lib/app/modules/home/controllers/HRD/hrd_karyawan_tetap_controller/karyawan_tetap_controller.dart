import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tetap.dart';
import 'package:qrm_dev/app/data/services/image_file_token.dart';

class KaryawanTetapController extends GetxController with Apis {
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;
  final ImageFileToken imageController = Get.put(ImageFileToken());

  Rxn<KaryawanTetap> user = Rxn<KaryawanTetap>();

  List<KaryawanTetap> listkaryawan = [];
  RxList<KaryawanTetap> karyawanTetap = <KaryawanTetap>[].obs;

  KaryawanTetap getKaryawan(int? id) {
    return karyawanTetap.firstWhere((e) => e.id == id,
        orElse: () => KaryawanTetap());
  }

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.karyawanTetap.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listkaryawan = KaryawanTetap.fromJsonList(res.data);

      karyawanTetap.value = listkaryawan;
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
      final res = await api.karyawanTetap.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;

      listkaryawan = KaryawanTetap.fromJsonList(res.data);

      // 🔥 WAJIB
      karyawanTetap.value = List.from(listkaryawan);
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

  Future deleteData(int id) async {
    try {
      final res =
          await api.karyawanTetap.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listkaryawan.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Get.snackbar('Berhasil', res.message ?? ' ');
      Get.back(result: res.data);
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

  void insertData(KaryawanTetap data) {
    listkaryawan.insert(0, data);
    isLoading.refresh();
  }

  void updateData(Map<String, dynamic> value, int id) {
    try {
      KaryawanTetap data = KaryawanTetap.fromJson(value);
      final index = listkaryawan.indexWhere((e) => e.id == id);
      logg('update list... index=$index, id=$id');

      if (index >= 0) {
        listkaryawan[index] = data;

        // kalau UI listen ke RxList:
        karyawanTetap.value = List.from(listkaryawan);

        // atau minimal refresh indikator:
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateData1(KaryawanTetap data, int id) {
    final index = listkaryawan.indexWhere((e) => e.id == id);
    logg('update list... index=$index, id=$id');

    if (index >= 0) {
      listkaryawan[index] = data;
      karyawanTetap.value = List.from(listkaryawan);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listkaryawan.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res =
          await api.karyawanTetap.getData({...query, 'search': searchC.text});
      final data = KaryawanTetap.fromJsonList(res.data);
      listkaryawan.addAll(data);
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
