import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/kendaraan_logistik.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';

class KendaraanLogistikJktController extends GetxController with Apis {
  final forms = LzForm.make([
    'id',
    'kode_aset',
    'nama_aset',
    'jumlah',
    'harga_perolehan',
    'tgl_beli',
    'no_pol',
    'tgl_qir',
    'tgl_samsat',
    'keterangan',
    'status',
    'penanggung_jawab',
    'image',
    'qr_code',
    'created_at',
    'user_name',
    'nama_kategori',
    'status_label',
  ]);

  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;

  List<KendaraanLogistik> listData = [];
  RxList<KendaraanLogistik> data = <KendaraanLogistik>[].obs;
  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  String? token;
  void setToken() {
    token = storage.read('token');
  }

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.kendaraanLogistik.getDataJkt(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = KendaraanLogistik.fromJsonList(res.data);
      data.value = listData;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteData(int id) async {
    try {
      final res = await api.kendaraanLogistik
          .deleteDataJkt(id)
          .ui
          .loading('Menghapus...');
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

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    data.value = listData
        .where((logistik) =>
            logistik.namaAset?.toLowerCase().contains(searchQuery.value) ??
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

  void insertData(KendaraanLogistik data) {
    listData.insert(0, data);
    isLoading.refresh();
  }

  void updateData(KendaraanLogistik data, int id) {
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
      final res = await api.kendaraanLogistik.getDataJkt(query);
      final data = KendaraanLogistik.fromJsonList(res.data);
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
