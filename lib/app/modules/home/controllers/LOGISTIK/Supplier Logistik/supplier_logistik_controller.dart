import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/supplier.dart';

class SupplierLogistikController extends GetxController with Apis {
  final forms = LzForm.make([
    'nama_perusahaan',
    'cp1',
    'cp2',
    'cp3',
    'email1',
    'email2',
    'email3',
    'alamat',
    'no_telp1',
    'no_telp2',
    'no_telp3',
    'no_fax',
    'npwp',
    'rek1',
    'bank1',
    'rek2',
    'bank2',
    'rek3',
    'bank3',
    'created_at',
  ]);

  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;
  final formDetails = <FormManager>[].obs;

  List<Supplier> listData = [];
  RxList<Supplier> data = <Supplier>[].obs;
  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.supplier.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = Supplier.fromJsonList(res.data);
      data.value = listData;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteData(int id) async {
    try {
      final res = await api.supplier.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listData.removeWhere((e) => e.id == id);
      isLoading.refresh();
      Get.snackbar('Berhasil', res.message ?? '');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void insertData(Supplier data) {
    listData.insert(0, data);
    isLoading.refresh();
  }

  void updateData(Supplier data, int id) {
    int index = listData.indexWhere((e) => e.id == id);
    if (index >= 0) {
      listData[index] = data;
      isLoading.refresh();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    data.value = listData
        .where((data) =>
            data.namaPerusahaan?.toLowerCase().contains(searchQuery.value) ??
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
      if (listData.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.supplier.getData(query);
      final data = Supplier.fromJsonList(res.data);
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
