import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/hrd_cuti.dart';

class HrdCutiBelumValidasiController extends GetxController with Apis {
  final forms = LzForm.make([
    "id",
    "user_id",
    "dep_id",
    "tgl_cuti",
    "perihal",
    "keterangan",
    "cuti_from",
    "cuti_to",
    "lama_cuti",
    "status_hrd",
    "approval",
    "status_dir_keuangan",
    "aprroved_by",
    "created_at",
    "user_name",
    "approval_name",
    "aprroved_by_name",
  ]);
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;

  List<HrdCuti> listCuti = [];
  RxList<HrdCuti> cuti = <HrdCuti>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final id = Get.parameters['id'];

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.hrdCuti.dataBelum(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listCuti = HrdCuti.fromJsonList(res.data);

      cuti.value = listCuti;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onSubmit() async {
    try {} catch (e, s) {
      Toast.dismiss();
      Errors.check(e, s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    cuti.value = listCuti
        .where((data) =>
            data.userName?.toLowerCase().contains(searchQuery.value) ?? false)
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

  void insertData(HrdCuti data) {
    listCuti.insert(0, data);
    isLoading.refresh();
  }

  void updateData(HrdCuti data, int id) {
    try {
      int index = listCuti.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listCuti[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listCuti.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.hrdCuti.dataBelum(query);
      final data = HrdCuti.fromJsonList(res.data);
      listCuti.addAll(data);
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
