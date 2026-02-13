import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20it/rab_it/rab_it.dart';
import 'package:qrm_dev/app/data/services/filter_mount_rab_it.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class RabRndBelumValidasiController extends GetxController with Apis {
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;
  RxString orderDir = 'asc'.obs;

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;

  List<RabIt> listrab = [];
  RxList<RabIt> rab = <RabIt>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {
        'page': page,
        'per_page': 10,
        'order_dir': orderDir.value,
      };

  Future getData() async {
    try {
      ListItemAnimasi.animatedItems.clear();

      page = 1;
      isLoading.value = true;
      final res = await api.rabGlobal.getDataBelumValidasiRnd(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listrab = RabIt.fromJsonList(res.data);

      rab.value = listrab;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, List<RabIt>> get rabGroupedByBulan {
    Map<String, List<RabIt>> grouped = {};

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
          .getDataBelumValidasiRnd({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      rab.value = RabIt.fromJsonList(res.data);
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

  void insertData(RabIt data) {
    listrab.insert(0, data);
    isLoading.refresh();
  }

  void updateData(RabIt data, int id) {
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
          .getDataBelumValidasiRnd({...query, 'search': searchC.text});
      final data = RabIt.fromJsonList(res.data);
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
