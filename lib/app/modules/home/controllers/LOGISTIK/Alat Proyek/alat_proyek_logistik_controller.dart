import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/alat_proyek.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';

class AlatProyekLogistikController extends GetxController with Apis {
  final forms = LzForm.make([
    'id',
    'kode_alat',
    'type',
    'nama_alat',
    'jumlah',
    'harga_satuan',
    'harga_perolehan',
    'status',
    'keterangan',
    'tgl_beli',
    'kantor',
    'image',
    'created_at',
    'qr_code',
    'tgl_service',
    'regional_name',
    'departemen_name',
    'proyek_name',
    'created_by_name',
    'pm_name',
  ]);

  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;

  List<AlatProyek> listAset = [];
  RxList<AlatProyek> aset = <AlatProyek>[].obs;
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
      final res = await api.alatProyek.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listAset = AlatProyek.fromJsonList(res.data);
      aset.value = listAset;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteData(int id) async {
    try {
      final res =
          await api.alatProyek.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listAset.removeWhere((e) => e.id == id);
      isLoading.refresh();
      Get.snackbar('Berhasil', res.message ?? '');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isSearching = false.obs;
  RxBool isPaginateSearch = false.obs;
  String keyword = '';
  TextEditingController searchC = TextEditingController();

  Future updateSearchQuery(String value) async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.alatProyek.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listAset = AlatProyek.fromJsonList(res.data);
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

  void insertData(AlatProyek data) {
    listAset.insert(0, data);
    isLoading.refresh();
  }

  void updateData(AlatProyek data, int id) {
    int index = listAset.indexWhere((e) => e.id == id);
    if (index >= 0) {
      listAset[index] = data;
      isLoading.refresh();
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listAset.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res =
          await api.alatProyek.getData({...query, 'search': searchC.text});
      final data = AlatProyek.fromJsonList(res.data);
      listAset.addAll(data);
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
