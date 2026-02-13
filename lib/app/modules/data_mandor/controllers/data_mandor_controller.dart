import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/data_mandor/data_mandor.dart';

class DataMandorController extends GetxController with Apis {
  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;
  final forms = LzForm.make([
    'nama',
    'alamat_ktp',
    'no_hp',
    'alamat_domisili',
    'ktp',
    'kode',
    'created_at',
    'created_by',
    'status',
    'harga',
    'ketepatan_waktu',
    'kualitas_pekerjaan',
    'kepatuhan_safety',
    'komunikasi',
    'nilai_total',
    'rating',
    'spesialis',
    'update_by',
    'created_name',
    'update_name',
  ]);

  List<DataMandor> listDataMandor = [];
  RxList<DataMandor> rxDataMan = <DataMandor>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.dataMandor.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listDataMandor = DataMandor.fromJsonList(res.data);
      rxDataMan.value = listDataMandor;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deletet(int id) async {
    try {
      final res = await api.dataMandor.deletes(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listDataMandor.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Toast.success('Data berhasil dihapus');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    rxDataMan.value = listDataMandor
        .where((logistik) =>
            logistik.nama?.toLowerCase().contains(searchQuery.value) ?? false)
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

  void insertData(DataMandor data) {
    listDataMandor.insert(0, data);
    isLoading.refresh();
  }

  void updateData(DataMandor data, int id) {
    try {
      int index = listDataMandor.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listDataMandor[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listDataMandor.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.dataMandor.getData(query);
      final data = DataMandor.fromJsonList(res.data);
      listDataMandor.addAll(data);
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
