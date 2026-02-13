import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/rab_validasi/rab_validasi.dart';
import 'package:qrm_dev/app/data/services/ext.dart';

class RabBelumValidasiController extends GetxController with Apis {
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;

  List<RabValidasi> listrab = [];
  RxList<RabValidasi> rab = <RabValidasi>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.rabGlobal.getDataBelumValidasiHrd(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listrab = RabValidasi.fromJsonList(res.data);

      rab.value = listrab;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, List<RabValidasi>> get rabGroupedByBulan {
    Map<String, List<RabValidasi>> grouped = {};

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
          .getDataBelumValidasiHrd({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      rab.value = RabValidasi.fromJsonList(res.data);
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

  void insertData(RabValidasi data) {
    listrab.insert(0, data);
    isLoading.refresh();
  }

  void updateData(RabValidasi data, int id) {
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
          .getDataBelumValidasiHrd({...query, 'search': searchC.text});
      final data = RabValidasi.fromJsonList(res.data);

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
