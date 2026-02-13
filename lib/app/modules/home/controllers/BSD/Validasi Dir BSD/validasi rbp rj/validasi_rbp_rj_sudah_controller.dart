import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Bindings;

import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/rbp_rb/rbp_rb.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/rbp_rb_nohide/rbp_rb_nohide.dart';

class ValidasiRbpRjSudahController extends GetxController with Apis {
  final forms = LzForm.make([
    // head utama
    'id',
    'kode_rbp',
    'kode_proyek',
    'total_material_utama',
    'total_material_tambahan',
    'total_upah_tk',
    'total_by_alat_utama',
    'total_by_alat_tambahan',
    'total_biaya_akomodasi',
    'total_beban_proyek',
    'nilai_kontrak',
    'nilai_pendapatan_95',
    'm_fee_kantor',
    'k_fee_kantor',
    'pph',
    'dpp_pph',
    'ppn',
    'scf',
    'netto',
    'estimasi_laba',
    'retensi',
    'prestasi_laba',
    'prepared_by',
    'status_pm',
    'validasi_pm',
    'status_gm',
    'validasi_gm',
    'status_dirtek',
    'validasi_dirtek',
    'status_bsd',
    'validasi_bsd',
    'approval',
    'status_dir_keuangan',
    'approved_by',
    'status_dir_utama',
    'created_at',
    'no_hide_rbp',
    'validasi_pm_name',
    'validasi_gm_name',
    'validasi_dirtek_name',
    'validasi_bsd_name',
    'approval_name',
    'approved_by_name',

    // proyek nested
    'id',
    'kode_proyek',
    'status_proyek',
    'man_fee_kantor',
    'kom_fee_kantor',
    'nilai_pph',
    'pot_pph',
    'sisa_pot_pph',
    'nilai_ppn',
    'nilai_ref',
    'nilai_scf',
    'dpp_pendapatan',
    'no_kontrak',
    'tgl_kontrak',
    'judul_kontrak',
    'nilai_kontrak',
    'durasi_kontrak',
    'durasi_proyek',
    'lokasi_proyek',
    'nama_pemberi_kerja',
    'jumlah_total',
    'diskon',
    'jml_diskon',
    'harga_setelah_diskon',
    'keuntungan',
    'jml_keuntungan',
    'harga_setelah_keuntungan',
    'dibulatkan',
    'ppn_total',
    'grand_total',
    'created_by',
    'no_hide',
    'created_at',
    'keterangan',
    'area_proyek',
    'jenis_proyek',
    'jenis_kontrak',
    'provinsi',
    'vendor',

// material utama
    'id',
    'kode_rbp',
    'kode_proyek',
    'no_hide_rbp',
    'uraian_mu',
    'jumlah_mu',
    'satuan_id_mu',
    'harga_modal',
    'total_harga_mu',
    'created_at',
    'satuan',
  ]);

  RxInt tab = 0.obs;

  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;
  RxList<RbpRbNohide> detailDatas = <RbpRbNohide>[].obs;
  RxBool isDetailLoading = false.obs;
  RbpRbNohide? details;

  List<RbpRb> listData = [];
  RxList<RbpRb> datas = <RbpRb>[].obs;
  int page = 1, total = 0;

  var expandedItems = <int>{}.obs;

  Map<String, dynamic> get query =>
      {'page': page, 'per_page': 10, 'validator': 'bsd'};

  void toggleExpand(int index) {
    if (expandedItems.contains(index)) {
      expandedItems.remove(index);
    } else {
      expandedItems.add(index);
    }
  }

  Future getData() async {
    try {
      final query = {'limit': 15, 'validator': 'bsd'};

      page = 1;
      isLoading.value = true;
      final res = await api.rbpRb.getDatarjSudah(query);
      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = RbpRb.fromJsonList(res.data);
      datas.value = listData;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getDetailByNoHide(String noHide) async {
    try {
      // kalau data sudah ada, langsung return
      if (detailDatas.isNotEmpty && detailDatas.first.noHideRbp == noHide) {
        return;
      }

      isDetailLoading.value = true;
      detailDatas.clear();

      final res = await api.rbpRb.getDataRjDetail(noHide);

      if (res.data != null && res.data is Map) {
        final newData = RbpRbNohide.fromJson(res.data);
        detailDatas.add(newData);
        forms.fill(newData.toJson());
      } else if (res.data != null && res.data is List) {
        detailDatas.addAll(RbpRbNohide.fromJsonList(res.data));
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isDetailLoading.value = false;
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
      final res = await api.rbpRb.getDatarjSudah({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = RbpRb.fromJsonList(res.data);
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

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listData.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res =
          await api.rbpRb.getDatarjSudah({...query, 'search': searchC.text});
      final data = RbpRb.fromJsonList(res.data);
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
