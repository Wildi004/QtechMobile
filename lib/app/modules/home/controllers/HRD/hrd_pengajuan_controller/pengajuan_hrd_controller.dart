import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/pengajuan_all/detail.dart';
import 'package:qrm/app/data/models/pengajuan_all/pengajuan_all.dart';
import 'package:qrm/app/data/models/pengajuan_hrd/pengajuan_hrd.dart';

class PengajuanHrdController extends GetxController with Apis {
  PengajuanHrd? data;
  PengajuanAll? data1;
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

  List<PengajuanHrd> listPengajuan = [];
  RxList<PengajuanHrd> pengajuan = <PengajuanHrd>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final id = Get.parameters['id'];

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.pengajuanHrd.getData(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listPengajuan = PengajuanHrd.fromJsonList(res.data);

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

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    pengajuan.value = listPengajuan
        .where((data) =>
            data.noPengajuan?.toLowerCase().contains(searchQuery.value) ??
            false)
        .toList();
  }

  PengajuanAll details = PengajuanAll();
  RxList<Detail> cards = RxList([]);

  Future getDetails(PengajuanHrd data) async {
    try {
      String nohide = data.noHide ?? '';
      final res = await api.pengajuanHrd.getDataByNoHide(nohide);
      details = PengajuanAll.fromJson(res.data ?? {});
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
    if (data != null) {
      forms.fill(data!.toJson());
    }
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void insertData(PengajuanHrd data) {
    listPengajuan.insert(0, data);
    isLoading.refresh();
  }

  void updateData(PengajuanHrd data, String noHide) {
    try {
      int index = listPengajuan.indexWhere((e) => e.noHide == noHide);
      if (index >= 0) {
        listPengajuan[index] = data;
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
      final res = await api.pengajuanHrd.getData(query);
      final data = PengajuanHrd.fromJsonList(res.data);
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
