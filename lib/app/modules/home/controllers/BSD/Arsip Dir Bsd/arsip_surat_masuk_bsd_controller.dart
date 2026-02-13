import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/arsip_surat_masuk_bsd.dart';

class ArsipSuratMasukBsdController extends GetxController with Apis {
  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
  List<ArsipSuratMasukBsd> listData = [];
  RxList<ArsipSuratMasukBsd> data = <ArsipSuratMasukBsd>[].obs;
  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  RxString searchQuery = "".obs;

  Future getBrosur() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.arsipSuratMasukBsd.getData(query);
      total = res.body?['pagination']?['total_records'] ?? 0;
      final list = res.body?['data'] ?? [];
      listData = ArsipSuratMasukBsd.fromJsonList(list);
      data.value = listData;
      logg('data brosur data: $listData');
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  TextEditingController searchC = TextEditingController();

  Future updateSearchQuery(String value) async {
    try {
      page = 1;
      isLoading.value = true;
      final res =
          await api.arsipSuratMasukBsd.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = ArsipSuratMasukBsd.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteData(int id) async {
    try {
      final res = await api.arsipSuratMasukBsd
          .deleteData(id)
          .ui
          .loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listData.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Toast.success('Data berhasil dihapus');
    } catch (e, s) {
      Errors.check(e, s);
    }
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

  void insertData(ArsipSuratMasukBsd data) {
    listData.insert(0, data);
    isLoading.refresh();
  }

  void updateData(ArsipSuratMasukBsd data, int id) {
    try {
      int index = listData.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listData[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listData.length >= total || isPaginate.value) {
        return;
      }
      page++;
      isPaginate.value = true;
      final res = await api.arsipSuratMasukBsd.getData(query);
      final data = ArsipSuratMasukBsd.fromJsonList(res.data);
      listData.addAll(data);
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
