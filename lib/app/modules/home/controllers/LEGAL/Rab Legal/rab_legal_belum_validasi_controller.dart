import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20legal/rab_legal/rab_legal.dart';
import 'package:qrm_dev/app/data/services/filter_mount_rab_it.dart';

class RabLegalBelumValidasiController extends GetxController with Apis {
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;
  RxString orderDir = 'asc'.obs;

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;

  List<RabLegal> listrab = [];
  RxList<RabLegal> rab = <RabLegal>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {
        'page': page,
        'per_page': 10,
        'order_dir': orderDir.value,
      };

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.rabGlobal.getDataBelumValidasiLegal(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listrab = RabLegal.fromJsonList(res.data);

      rab.value = listrab;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, List<RabLegal>> get rabGroupedByBulan {
    Map<String, List<RabLegal>> grouped = {};

    for (var item in rab) {
      final label = item.bulanTahunLabel;

      if (!grouped.containsKey(label)) {
        grouped[label] = [];
      }

      grouped[label]!.add(item);
    }

    return grouped;
  }

  Future<void> onSubmit() async {
    try {} catch (e, s) {
      Toast.dismiss();
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
      final res = await api.rabGlobal
          .getDataBelumValidasiLegal({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      rab.value = RabLegal.fromJsonList(res.data);
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

  @override
  void onInit() {
    super.onInit();
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void insertData(RabLegal data) {
    listrab.insert(0, data);
    isLoading.refresh();
  }

  void updateData(RabLegal data, int id) {
    try {
      int index = listrab.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listrab[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listrab.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.rabGlobal
          .getDataBelumValidasiLegal({...query, 'search': searchC.text});
      final data = RabLegal.fromJsonList(res.data);
      listrab.addAll(data);
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
