import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/surat_internal.dart';

class SuratInternalController extends GetxController with Apis {
  RxBool isloading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;

  List<SuratInternal> suratLs = [];
  RxList<SuratInternal> rxSuratInter = <SuratInternal>[].obs;

  int page = 1, total = 0;

  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      page = 1;

      isloading.value = true;
      final res = await api.suratInternal.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      suratLs = SuratInternal.fromJsonList(res.data);
      rxSuratInter.value = suratLs;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isloading.value = false;
    }
  }

  Future deletetdkn(int id) async {
    try {
      final res =
          await api.suratInternal.deleteSI(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      suratLs.removeWhere((e) => e.id == id);

      isloading.refresh();

      Toast.success('Data berhasil dihapus');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    rxSuratInter.value = suratLs
        .where((logistik) =>
            logistik.nama?.toLowerCase().contains(searchQuery.value) ?? false)
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

  void insertData(SuratInternal data) {
    suratLs.insert(0, data);
    isloading.refresh();
  }

  void updateData(SuratInternal data, int id) {
    try {
      int index = suratLs.indexWhere((e) => e.id == id);
      if (index >= 0) {
        suratLs[index] = data;
        isloading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (suratLs.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.suratInternal.getData(query);
      final data = SuratInternal.fromJsonList(res.data);
      suratLs.addAll(data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      Utils.timer(() {
        isPaginate.value = false;
        isloading.refresh();
      }, 1.s);
    }
  }
}
