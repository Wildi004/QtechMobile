import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/capaian_kerja1/capaian_kerja1.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class CapaianKerja1Controller extends GetxController with Apis {
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;
  RxInt statusCode = 0.obs;
  List<Capaian1> listCapaian = [];
  RxList<Capaian1> capaian = <Capaian1>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      ListItemAnimasi.animatedItems.clear();

      page = 1;
      isLoading.value = true;
      final res = await api.capaianKerja1.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listCapaian = Capaian1.fromJsonList(res.data);
      capaian.value = listCapaian;

      logg('data satuan logistik $listCapaian');
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

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    capaian.value = listCapaian
        .where((logistik) =>
            logistik.departemen?.toLowerCase().contains(searchQuery.value) ??
            false)
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listCapaian.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.capaianKerja1.getData(query);
      final data = Capaian1.fromJsonList(res.data);
      listCapaian.addAll(data);
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
