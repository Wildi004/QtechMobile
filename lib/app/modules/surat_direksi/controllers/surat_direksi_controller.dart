import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/surat_direksi.dart';

class SuratDireksiController extends GetxController with Apis {
  RxString searchQuery = "".obs;

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
  final forms = LzForm.make([
    'no_sk',
    'nama',
    'tgl_sk',
    'image',
    'user_id',
    'created_at',
    'user_name',
  ]);

  List<SuratDireksi> listSuratDir = [];
  RxList<SuratDireksi> rxSuratDir = <SuratDireksi>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final id = Get.parameters['id'];

  Future getSuratDir() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.suratDireksi.getData(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listSuratDir = SuratDireksi.fromJsonList(res.data);

      rxSuratDir.value = listSuratDir;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteSK(int id) async {
    try {
      final res =
          await api.suratDireksi.deleteteSk(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listSuratDir.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Toast.success('Data berhasil dihapus');
    } catch (e, s) {
      Errors.check(e, s);
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
    rxSuratDir.value = listSuratDir
        .where((logistik) =>
            logistik.nama?.toLowerCase().contains(searchQuery.value) ?? false)
        .toList();
  }

  Future onPageInit() async {
    try {
      await getSuratDir();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getSuratDir();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void insertData(SuratDireksi data) {
    listSuratDir.insert(0, data);
    isLoading.refresh();
  }

  void updateData(SuratDireksi data, int id) {
    try {
      int index = listSuratDir.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listSuratDir[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listSuratDir.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.suratDireksi.getData(query);
      final data = SuratDireksi.fromJsonList(res.data);
      listSuratDir.addAll(data);
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
