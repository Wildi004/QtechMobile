import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20it/laporan_it.dart';
import 'package:qrm_dev/app/data/models/models%20it/laporan_it_mingguan.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class LaporanRndController extends GetxController with Apis {
  RxString searchQuery = "".obs;
  RxBool isLoading = true.obs;
  var isExpanded = false.obs;

  List<LaporanIt> listRk = [];
  RxList<LaporanIt> rk = <LaporanIt>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      ListItemAnimasi.animatedItems.clear();

      page = 1;
      isLoading.value = true;
      final res = await api.rk.getDataRnd(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listRk = LaporanIt.fromJsonList(res.data);
      rk.value = listRk;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  RxList<LaporanItMingguan> detailList = <LaporanItMingguan>[].obs;

  Future loadDetail(String encryptedMinggu) async {
    try {
      isLoading.value = true;
      final res = await api.rk.getMingguRnd(encryptedMinggu);
      final rawList = res.data as List<dynamic>;
      detailList.value = LaporanItMingguan.fromJsonList(rawList);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();

    rk.value = listRk
        .where((data) =>
            data.minggu?.toLowerCase().contains(searchQuery.value) ?? false)
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

  void insertData(LaporanIt data) {
    listRk.insert(0, data);
    isLoading.refresh();
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listRk.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.rk.getDataRnd(query);
      final data = LaporanIt.fromJsonList(res.data);
      listRk.addAll(data);
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
