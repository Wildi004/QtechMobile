import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/pengajuan%20global/pengajuan%20sudah%20validasi/pengajuan_sudah_validasi/detail.dart';
import 'package:qrm_dev/app/data/models/pengajuan%20global/pengajuan%20sudah%20validasi/pengajuan_sudah_validasi/pengajuan_sudah_validasi.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_pengajuan_controller/belum_validasi_pengajuan_controller.dart';

class PengajuanHrdController extends GetxController with Apis {
  PengajuanSudahValidasi? data;
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

  List<PengajuanSudahValidasi> listPengajuan = [];
  RxList<PengajuanSudahValidasi> pengajuan = <PengajuanSudahValidasi>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final id = Get.parameters['id'];

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.pengajuanGlobal.getDataHrdSudahValidasi(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listPengajuan = PengajuanSudahValidasi.fromJsonList(res.data);

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
          .getDataHrdSudahValidasi({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listPengajuan = PengajuanSudahValidasi.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  PengajuanSudahValidasi details = PengajuanSudahValidasi();
  RxList<DetailValidasi> cards = RxList([]);

  Future getDetails(PengajuanSudahValidasi data) async {
    try {
      String nohide = data.noHide ?? '';
      final res = await api.pengajuanGlobal.getDataHrdByNoHide(nohide);
      details = PengajuanSudahValidasi.fromJson(res.data ?? {});
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

  void insertData(PengajuanSudahValidasi data) {
    try {
      final controller = Get.find<BelumValidasiPengajuanController>();
      controller.pengajuan.insert(0, data);
      controller.isLoading.refresh();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateData(PengajuanSudahValidasi data, String noHide) {
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
          .getDataHrdSudahValidasi({...query, 'search': searchC.text});
      final data = PengajuanSudahValidasi.fromJsonList(res.data);
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
