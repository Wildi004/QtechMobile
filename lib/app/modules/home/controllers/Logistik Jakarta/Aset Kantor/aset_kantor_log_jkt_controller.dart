import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik%20jkt/aset_kantor_log_jkt.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';

class AsetKantorLogJktController extends GetxController with Apis {
  final forms = LzForm.make([
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
    'nama_kategori',
    'user_name',
    'status_label'
  ]);

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;

  List<AsetKantorLogJkt> listAset = [];
  RxList<AsetKantorLogJkt> aset = <AsetKantorLogJkt>[].obs;
  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'limit': 10};
  String? token;
  void setToken() {
    token = storage.read('token');
  }

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.asetKantorLogJkt.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listAset = AsetKantorLogJkt.fromJsonList(res.data);
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
          await api.asetKantorLogJkt.deleteData(id).ui.loading('Menghapus...');
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
      final res =
          await api.asetKantorLogJkt.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listAset = AsetKantorLogJkt.fromJsonList(res.data);
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

  void insertData(AsetKantorLogJkt data) {
    listAset.insert(0, data);
    isLoading.refresh();
  }

  void updateData(AsetKantorLogJkt data, int id) {
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
      final res = await api.asetKantorLogJkt
          .getData({...query, 'search': searchC.text});
      final data = AsetKantorLogJkt.fromJsonList(res.data);
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
