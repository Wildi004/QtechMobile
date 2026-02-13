import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/surat_masuk/surat_masuk.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class SuratMasukRndController extends GetxController with Apis {
  RxString searchQuery = "".obs;
  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
  List<SuratMasuk> listSurat = [];
  RxList<SuratMasuk> surat = <SuratMasuk>[].obs;
  int page = 1, total = 0;
  RxBool isPaginate = false.obs;

  late String depId;

  Map<String, dynamic> get query => {
        'page': page,
        'per_page': 10,
      };

  Future getData() async {
    try {
      ListItemAnimasi.animatedItems.clear();

      page = 1;
      isLoading.value = true;

      final res = await api.suratMasuk.getData(depId, query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listSurat = SuratMasuk.fromJsonList(res.data);
      surat.value = listSurat;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future onPaginate() async {
    try {
      if (listSurat.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;

      final res = await api.suratMasuk.getData(depId, query);
      final data = SuratMasuk.fromJsonList(res.data);

      listSurat.addAll(data);
      surat.value = listSurat;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      Utils.timer(() {
        isPaginate.value = false;
        isLoading.refresh();
      }, 1.s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();

    surat.value = listSurat
        .where((data) =>
            data.userPenerima?.toLowerCase().contains(searchQuery.value) ??
            false)
        .toList();
  }

  Future onPageInit() async {
    try {
      await getData();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void insertData(SuratMasuk data) {
    listSurat.insert(0, data);
    surat.insert(0, data);
    isLoading.refresh();
  }

  @override
  void onInit() {
    super.onInit();

    depId = '12';
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }
}
