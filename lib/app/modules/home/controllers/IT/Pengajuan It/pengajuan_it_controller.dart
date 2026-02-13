import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20it/pengajuan_it/detail.dart';
import 'package:qrm_dev/app/data/models/models%20it/pengajuan_it/pengajuan_it.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

import 'pengajuan_it_belum_validasi_controller.dart';

class PengajuanItController extends GetxController with Apis {
  PengajuanIt? data;
  final isFilled = false.obs;
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;
  final forms = LzForm.make([
    'no_pengajuan',
    'sub_total',
    "tgl_pengajuan",
    "item_id",
    "rab_id",
    "nama_barang",
    "qty",
    "harga",
    'dep_name',
    'jenis_rab',
  ]);
  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
  RxList<FormManager> formRabs = RxList([]);

  List<PengajuanIt> listPengajuan = [];
  RxList<PengajuanIt> pengajuan = <PengajuanIt>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final id = Get.parameters['id'];

  Future getData() async {
    try {
      ListItemAnimasi.animatedItems.clear();

      page = 1;
      isLoading.value = true;
      final res = await api.pengajuanGlobal.getDataItSudahValidasi(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listPengajuan = PengajuanIt.fromJsonList(res.data);

      pengajuan.value = listPengajuan;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onSubmit() async {
    try {} catch (e, s) {
      Toast.dismiss();
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
      final res = await api.pengajuanGlobal
          .getDataItSudahValidasi({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listPengajuan = PengajuanIt.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  PengajuanIt details = PengajuanIt();
  RxList<DetailPengajuanIt> cards = RxList([]);

  Future getDetails(PengajuanIt data) async {
    try {
      String nohide = data.noHide ?? '';
      final res = await api.pengajuanGlobal.getDataItByNoHide(nohide);
      details = PengajuanIt.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];
    } catch (e, s) {
      Errors.check(e, s);
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

    // listener ketika tab berubah
    ever(tab, (value) {
      if (value == 1) {
        // Tab "Sudah Validasi"
        getData();
      }
    });

    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void insertData(PengajuanIt data) {
    try {
      final controller = Get.find<PengajuanItBelumValidasiController>();
      controller.pengajuan.insert(0, data);
      controller.isLoading.refresh();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateData(PengajuanIt data, String noHide) {
    try {
      int index = listPengajuan.indexWhere((e) => e.noHide == noHide);
      if (index >= 0) {
        listPengajuan[index] = data;
        pengajuan.value = List.from(listPengajuan);

        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listPengajuan.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.pengajuanGlobal
          .getDataItSudahValidasi({...query, 'search': searchC.text});
      final data = PengajuanIt.fromJsonList(res.data);
      listPengajuan.addAll(data);
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
