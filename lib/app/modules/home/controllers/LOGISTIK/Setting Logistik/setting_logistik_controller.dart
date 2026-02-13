import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/satuan_logistik.dart';

class SettingLogistikController extends GetxController with Apis {
  final forms = LzForm.make([
    'satuan',
  ]);

  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;

  List<SatuanLogistik> listData = [];
  RxList<SatuanLogistik> data = <SatuanLogistik>[].obs;
  int page = 1, total = 0;

  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.satuanLogistik.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = SatuanLogistik.fromJsonList(res.data);
      data.value = listData;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    data.value = listData
        .where((logistik) =>
            logistik.satuan?.toLowerCase().contains(searchQuery.value) ?? false)
        .toList();
  }

  Future delete(int id) async {
    try {
      final res =
          await api.satuanLogistik.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listData.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Get.snackbar('Berhasil', res.message.toString());
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateData(SatuanLogistik data, int id) {
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

  void insertData(SatuanLogistik data) {
    listData.insert(0, data);
    isLoading.refresh();
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listData.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.satuanLogistik.getData(query);
      final data = SatuanLogistik.fromJsonList(res.data);
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
