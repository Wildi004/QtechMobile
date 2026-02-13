import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/arsip_perusahaan.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class ArsipPerusahaanController extends GetxController with Apis {
  final forms = LzForm.make([
    'nama',
    'tgl_upload',
    'image',
    'expired_date',
    'tgl_berlaku_dok',
    'keterangan',
    'user_name',
  ]);
  var selectedIndex = (-1).obs;
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;
  final formDetails = <FormManager>[].obs;

  List<ArsipPerusahaan> listData = [];
  RxList<ArsipPerusahaan> data = <ArsipPerusahaan>[].obs;
  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      ListItemAnimasi.animatedItems.clear();

      page = 1;
      isLoading.value = true;
      final res = await api.arsipPerusahaan.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = ArsipPerusahaan.fromJsonList(res.data);
      data.value = listData;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteData(int id) async {
    try {
      final res =
          await api.arsipPerusahaan.deleteData(id).ui.loading('Menghapus...');
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

  void insertData(ArsipPerusahaan data) {
    listData.insert(0, data);
    isLoading.refresh();
  }

  RxBool isSearching = false.obs;
  RxBool isPaginateSearch = false.obs;
  String keyword = '';
  TextEditingController searchC = TextEditingController();

  Future updateSearchQuery(String value) async {
    try {
      page = 1;
      isLoading.value = true;
      final res =
          await api.arsipPerusahaan.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = ArsipPerusahaan.fromJsonList(res.data);
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

  void updateData(ArsipPerusahaan data, int id) {
    int index = listData.indexWhere((e) => e.id == id);
    if (index >= 0) {
      listData[index] = data;
      isLoading.refresh();
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
      final res =
          await api.arsipPerusahaan.getData({...query, 'search': searchC.text});
      final data = ArsipPerusahaan.fromJsonList(res.data);
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
