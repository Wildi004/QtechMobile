import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/arsip_surat_keluar_bsd.dart';

class ArsipSuratKeluarRndController extends GetxController with Apis {
  final forms = LzForm.make([
    'id',
    'kode_surat',
    'sifat',
    'perihal',
    'tgl_upload',
    'tgl_surat',
    'dep_id',
    'tipe',
    'tujuan',
    'image',
    'status_validasi',
    'validasi_by',
    'keterangan',
    'created_at',
    'user_name',
    'user_validator_name',
    'departemen',
  ]);
  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
  List<ArsipSuratKeluarBsd> listData = [];
  RxList<ArsipSuratKeluarBsd> data = <ArsipSuratKeluarBsd>[].obs;
  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  RxString searchQuery = "".obs;

  Future getBrosur() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.arsipSuratKeluarBsd.getDataRnd(query);
      total = res.body?['pagination']?['total_records'] ?? 0;
      final list = res.body?['data'] ?? [];
      listData = ArsipSuratKeluarBsd.fromJsonList(list);
      data.value = listData;
      logg('data brosur data: $listData');
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  TextEditingController searchC = TextEditingController();

  Future updateSearchQuery(String value) async {
    try {
      page = 1;
      isLoading.value = true;
      final res =
          await api.arsipSuratKeluarBsd.getDataRnd({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = ArsipSuratKeluarBsd.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deleteData(int id) async {
    try {
      final res = await api.arsipSuratKeluarBsd
          .deleteDataRnd(id)
          .ui
          .loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listData.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Toast.success('Data berhasil dihapus');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future onPageInit() async {
    try {
      await getBrosur();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getBrosur();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void insertData(ArsipSuratKeluarBsd data) {
    listData.insert(0, data);
    isLoading.refresh();
  }

  void updateData(ArsipSuratKeluarBsd data, int id) {
    try {
      int index = listData.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listData[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
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
      final res = await api.arsipSuratKeluarBsd.getDataRnd(query);
      final data = ArsipSuratKeluarBsd.fromJsonList(res.data);
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
