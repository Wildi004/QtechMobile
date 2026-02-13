import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/proyek_item/proyek_item.dart';

class MonitorController extends GetxController with Apis {
  final forms = LzForm.make([
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
    'no_hide',
    'created_at',
    'keterangan',
    'area_proyek',
    'jenis_proyek',
    'jenis_kontrak',
    'provinsi',
    'vendor',
  ]);

  var infoText = 'teks awal'.obs;

  RxString searchQuery = "".obs;
  var tabIndex = 0.obs;

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
  final selectedIndex = (-1).obs;
  List<ProyekItems> listMonitor = [];
  RxList<ProyekItems> rxmonitor = <ProyekItems>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.dataProyek.getDataProyek(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listMonitor = ProyekItems.fromJsonList(res.data);
      rxmonitor.value = listMonitor;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void toggleItem(int index) {
    if (selectedIndex.value == index) {
      selectedIndex.value = -1;
    } else {
      selectedIndex.value = index;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    rxmonitor.value = listMonitor
        .where((data) =>
            data.kodeProyek?.toLowerCase().contains(searchQuery.value) ?? false)
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

  void insertData(ProyekItems data) {
    listMonitor.insert(0, data);
    isLoading.refresh();
  }

  void updateData(ProyekItems data, int id) {
    try {
      int index = listMonitor.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listMonitor[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listMonitor.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.dataProyek.getDataProyek(query);
      final data = ProyekItems.fromJsonList(res.data);
      listMonitor.addAll(data);
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
