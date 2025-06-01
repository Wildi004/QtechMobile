import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/brosur_logistik.dart';

class BrosurLogistikController extends GetxController with Apis {
  RxString searchQuery = "".obs;

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;

  List<BrosurLogistik> listbl = [];

  RxList<BrosurLogistik> rxbl = <BrosurLogistik>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getBrosur() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.brosurLogistik.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listbl = BrosurLogistik.fromJsonList(res.data);
      logg('ini data brosur $res');

      rxbl.value = listbl;

      logg('data satuan logistik $listbl');
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteBrosur(int id) async {
    try {
      final res =
          await api.brosurLogistik.deleteBrosur(id).ui.loading('Menghapus...');
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
            logistik.nama?.toLowerCase().contains(searchQuery.value) ?? false)
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

  void insertData(BrosurLogistik data) {
    listbl.insert(0, data);
    isLoading.refresh();
  }

  void updateData(BrosurLogistik data, int id) {
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
      final res = await api.brosurLogistik.getData(query);
      final data = BrosurLogistik.fromJsonList(res.data);
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
