import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/arsip_lamaran.dart';

class ArsipLamaranController extends GetxController with Apis {
  var tabIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;

  final forms = LzForm.make([
    'id',
    'nama',
    'image',
    'tgl_upload',
    'tgl_lamaran',
    'posisi',
    'user_id',
    'lokasi_kantor',
    'status',
    'created_at',
    'user_name',
  ]);

  var isExpanded = false.obs;
  List<ArsipLamaran> listArsip = [];
  RxList<ArsipLamaran> arsip = <ArsipLamaran>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.arsipLamaran.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listArsip = ArsipLamaran.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future delete(int id) async {
    try {
      final res =
          await api.arsipLamaran.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listArsip.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Get.snackbar('Berhasil', res.message ?? '');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    logg('Search query: $query');
    arsip.value = listArsip
        .where((arsip) =>
            arsip.nama?.toLowerCase().contains(searchQuery.value) ?? false)
        .toList();
  }

  void insertData(ArsipLamaran data) {
    listArsip.insert(0, data);
    isLoading.refresh();
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
    getData();
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void updateData(ArsipLamaran data, int id) {
    try {
      int index = listArsip.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listArsip[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listArsip.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.arsipLamaran.getData(query);
      final data = ArsipLamaran.fromJsonList(res.data);
      listArsip.addAll(data);
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
