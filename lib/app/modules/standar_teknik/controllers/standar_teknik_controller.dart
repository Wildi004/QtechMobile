import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/standar_teknik.dart';

class StandarTeknikController extends GetxController with Apis {
  RxString searchQuery = "".obs;
  RxBool isLoading = true.obs;
  final Api api = Api(); // instance Api langsung

  var isExpanded = false.obs;
  List<StandarTeknik> listbl = [];
  RxList<StandarTeknik> rxbl = <StandarTeknik>[].obs;
  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getBrosur() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.standarTeknik.getData(query);
      total = res.body?['pagination']?['total_records'] ?? 0;
      final list = res.body?['data'] ?? [];
      listbl = StandarTeknik.fromJsonList(list);
      rxbl.value = listbl;
      logg('data brosur logistik: $listbl');
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteBrosur(int id) async {
    try {
      final res =
          await api.standarTeknik.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listbl.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Toast.success('Data berhasil dihapus');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    rxbl.value = listbl
        .where((logistik) =>
            logistik.judul?.toLowerCase().contains(searchQuery.value) ?? false)
        .toList();
  }

  Future onPageInit() async {
    try {
      await getBrosur();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getBrosur();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void insertData(StandarTeknik data) {
    listbl.insert(0, data);
    isLoading.refresh();
  }

  void updateData(StandarTeknik data, int id) {
    try {
      int index = listbl.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listbl[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listbl.length >= total || isPaginate.value) {
        return;
      }
      page++;
      isPaginate.value = true;
      final res = await api.standarTeknik.getData(query);
      final data = StandarTeknik.fromJsonList(res.data);
      listbl.addAll(data);
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
