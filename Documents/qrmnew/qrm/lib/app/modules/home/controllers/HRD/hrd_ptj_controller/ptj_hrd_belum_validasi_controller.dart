import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/ptj_hrd/ptj_hrd.dart';

class PtjHrdBelumValidasiController extends GetxController with Apis {
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;

  List<PtjHrd> listPtj = [];
  RxList<PtjHrd> pengajuan = <PtjHrd>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final id = Get.parameters['id'];

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.ptjHrd.getDataBelum(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listPtj = PtjHrd.fromJsonList(res.data);

      pengajuan.value = listPtj;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onSubmit() async {
    try {} catch (e, s) {
      Toast.dismiss();
      Errors.check(e, s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    pengajuan.value = listPtj
        .where((data) =>
            data.noPtj?.toLowerCase().contains(searchQuery.value) ?? false)
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
    super.onInit();
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void insertData(PtjHrd data) {
    listPtj.insert(0, data);
    isLoading.refresh();
  }

  void updateData(PtjHrd data, int id) {
    try {
      int index = listPtj.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listPtj[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listPtj.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.ptjHrd.getDataBelum(query);
      final data = PtjHrd.fromJsonList(res.data);
      listPtj.addAll(data);
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
