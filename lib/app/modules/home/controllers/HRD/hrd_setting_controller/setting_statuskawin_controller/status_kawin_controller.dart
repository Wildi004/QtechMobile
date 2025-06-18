import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/status_kawin.dart';

class StatusKawinController extends GetxController with Apis {
  var tabIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;

  var isExpanded = false.obs;
  List<StatusKawin> liststatus = [];
  RxList<StatusKawin> status = <StatusKawin>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getStatus() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.statusKawin.getData(query);

      // set total untuk paginasi
      total = res.body?['pagination']?['total_records'] ?? 0;
      liststatus = StatusKawin.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future delete(int id) async {
    try {
      final res =
          await api.statusKawin.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      liststatus.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Get.snackbar('Berhasil', res.message.toString());
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    status.value = liststatus
        .where((status) =>
            status.keterangan?.toLowerCase().contains(searchQuery.value) ??
            false)
        .toList();
  }

  Future onPageInit() async {
    try {
      await getStatus();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    getStatus();
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void insertData(StatusKawin data) {
    liststatus.insert(0, data);
    isLoading.refresh();
  }

  void updateData(StatusKawin data, int id) {
    try {
      int index = liststatus.indexWhere((e) => e.id == id);
      if (index >= 0) {
        liststatus[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (liststatus.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.statusKawin.getData(query);
      final data = StatusKawin.fromJsonList(res.data);
      liststatus.addAll(data);
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
