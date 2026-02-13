import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/daftar_tkdn.dart';

class DaftarTkdnController extends GetxController with Apis {
  RxString searchQuery = "".obs;
  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
  final forms = LzForm.make([
    'nama',
    'tgl_upload',
  ]);
  List<DaftarTkdn> listDt = [];
  RxList<DaftarTkdn> rxDt = <DaftarTkdn>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getTkdn() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.daftarTkdn.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listDt = DaftarTkdn.fromJsonList(res.data);
      rxDt.value = listDt;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void updateData(DaftarTkdn data, int id) {
    try {
      int index = listDt.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listDt[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future deletetdkn(int? id) async {
    try {
      final res =
          await api.daftarTkdn.deletetdkn(id).ui.loading('Menghapus...');

      if (!res.status) {
        return Toast.error(res.message);
      }

      listDt.removeWhere((e) => e.id == id);

      rxDt.value = List.from(listDt);

      Toast.success('Data berhasil dihapus');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    rxDt.value = listDt
        .where((logistik) =>
            logistik.nama?.toLowerCase().contains(searchQuery.value) ?? false)
        .toList();
  }

  Future onPageInit() async {
    try {
      await getTkdn();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getTkdn();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void insertData(DaftarTkdn data) {
    listDt.insert(0, data);
    rxDt.value = List.from(listDt);
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listDt.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.daftarTkdn.getData(query);
      final data = DaftarTkdn.fromJsonList(res.data);
      listDt.addAll(data);
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
