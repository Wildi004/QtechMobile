import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tidak.dart';
import 'package:qrm_dev/app/data/services/image_file_token.dart';

class KaryawanTidakTetapController extends GetxController with Apis {
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;
  final ImageFileToken imageController = Get.put(ImageFileToken());

  Rxn<KaryawanTidak> user = Rxn<KaryawanTidak>();

  List<KaryawanTidak> listkaryawan = [];
  RxList<KaryawanTidak> karyawanTidak = <KaryawanTidak>[].obs;

  KaryawanTidak getKaryawan(int? id) {
    return karyawanTidak.firstWhere((e) => e.id == id,
        orElse: () => KaryawanTidak());
  }

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

  RxBool isSearching = false.obs;
  RxBool isPaginateSearch = false.obs;
  String keyword = '';
  TextEditingController searchC = TextEditingController();

  Future updateSearchQuery(String value) async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.karyawanTidak.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listkaryawan = KaryawanTidak.fromJsonList(res.data);
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
          await api.karyawanTidak.deleteData(id).ui.loading('Menghapus...');
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

  void insertData(KaryawanTidak data) {
    listkaryawan.insert(0, data);
    isLoading.refresh();
  }

  void updateData(Map<String, dynamic> value, int id) {
    try {
      KaryawanTidak data = KaryawanTidak.fromJson(value);
      final index = listkaryawan.indexWhere((e) => e.id == id);
      logg('update list... index=$index, id=$id');

      if (index >= 0) {
        listkaryawan[index] = data;

        karyawanTidak.value = List.from(listkaryawan);

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
      final res =
          await api.karyawanTidak.getData({...query, 'search': searchC.text});
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
