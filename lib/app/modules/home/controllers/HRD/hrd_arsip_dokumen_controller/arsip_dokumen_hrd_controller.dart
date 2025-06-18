import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/dokumen_hrd.dart';

class ArsipDokumenHrdController extends GetxController with Apis {
  var tabIndex = 0.obs;
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;

  final forms = LzForm.make([
    'id',
    'nama',
    'tgl_upload',
    'keterangan',
    'image',
    'user_id',
    'created_at',
    'user_name',
  ]);

  var isExpanded = false.obs;
  List<DokumenHrd> listDoc = [];
  RxList<DokumenHrd> arsip = <DokumenHrd>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.dokumenHrd.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listDoc = DokumenHrd.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future delete(int id) async {
    try {
      final res =
          await api.dokumenHrd.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listDoc.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Toast.success('Data berhasil dihapus');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void insertData(DokumenHrd data) {
    listDoc.insert(0, data);
    isLoading.refresh();
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    arsip.value = listDoc
        .where((arsip) =>
            arsip.nama?.toLowerCase().contains(searchQuery.value) ?? false)
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
    getData();
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void updateData(DokumenHrd data, int id) {
    try {
      int index = listDoc.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listDoc[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listDoc.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.dokumenHrd.getData(query);
      final data = DokumenHrd.fromJsonList(res.data);
      listDoc.addAll(data);
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
