import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/cuti.dart';

class SettingCutiController extends GetxController with Apis {
  var tabIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;

  var isExpanded = false.obs;
  List<Cuti> listcuti = [];
  RxList<Cuti> cuti = <Cuti>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.cuti.getData(query);

      // set total untuk paginasi
      total = res.body?['pagination']?['total_records'] ?? 0;
      listcuti = Cuti.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future delete(int id) async {
    try {
      final res = await api.cuti.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listcuti.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Get.snackbar('Berhasil', res.message.toString());
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void insertData(Cuti data) {
    listcuti.insert(0, data);
    isLoading.refresh();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    cuti.value = listcuti
        .where((cuti) =>
            cuti.user?.toLowerCase().contains(searchQuery.value) ?? false)
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
    getData();
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void updateData(Cuti data, int id) {
    try {
      int index = listcuti.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listcuti[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listcuti.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.cuti.getData(query);
      final data = Cuti.fromJsonList(res.data);
      listcuti.addAll(data);
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
