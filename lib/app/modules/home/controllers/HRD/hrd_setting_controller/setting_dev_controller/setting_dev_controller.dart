import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/departemen.dart';

class SettingDevController extends GetxController with Apis {
  var tabIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;

  var isExpanded = false.obs;
  List<Departemen> listdep = [];
  RxList<Departemen> dep = <Departemen>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getDep() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.departemen.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      dep.value = listdep;
      listdep = Departemen.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future delete(int id) async {
    try {
      final res =
          await api.departemen.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listdep.removeWhere((e) => e.id == id);
      dep.value = List.from(listdep);

      isLoading.refresh();

      Get.snackbar('Berhasil', res.message.toString());
    } catch (e, s) {
      Errors.check(e, s);
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
      final res = await api.departemen.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listdep = Departemen.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future onPageInit() async {
    try {
      await getDep();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    getDep();
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void insertData(Departemen data) {
    listdep.insert(0, data);
    dep.value = List.from(listdep);

    isLoading.refresh();
  }

  void updateData(Departemen data, int id) {
    try {
      int index = listdep.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listdep[index] = data;
        dep.value = List.from(listdep);

        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listdep.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res =
          await api.departemen.getData({...query, 'search': searchC.text});
      final data = Departemen.fromJsonList(res.data);
      listdep.addAll(data);
      dep.value = List.from(listdep);
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
