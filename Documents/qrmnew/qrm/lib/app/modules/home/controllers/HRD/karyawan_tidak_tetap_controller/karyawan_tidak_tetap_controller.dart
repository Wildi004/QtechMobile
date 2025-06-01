import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/karyawan_tidak.dart';

class KaryawanTidakTetapController extends GetxController with Apis {
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;

  Rxn<KaryawanTidak> user = Rxn<KaryawanTidak>();

  List<KaryawanTidak> listkaryawan = [];
  RxList<KaryawanTidak> karyawanTidak = <KaryawanTidak>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.karyawanTidak.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listkaryawan = KaryawanTidak.fromJsonList(res.data);

      karyawanTidak.value = listkaryawan;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    karyawanTidak.value = listkaryawan
        .where((data) =>
            data.name?.toLowerCase().contains(searchQuery.value) ?? false)
        .toList();
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

  void insertData(KaryawanTidak data) {
    listkaryawan.insert(0, data);
    isLoading.refresh();
  }

  void updateData(KaryawanTidak data, int id) {
    try {
      int index = listkaryawan.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listkaryawan[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
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
      final res = await api.karyawanTidak.getData(query);
      final data = KaryawanTidak.fromJsonList(res.data);
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
