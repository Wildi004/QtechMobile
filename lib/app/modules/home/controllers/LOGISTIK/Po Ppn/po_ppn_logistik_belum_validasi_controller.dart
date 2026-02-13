import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/po_ppn/po_ppn.dart';

class PoPpnLogistikBelumValidasiController extends GetxController with Apis {
  PoPpn? data;
  final isFilled = false.obs;
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;
  final forms = LzForm.make([
    'no_po',
    'tgl_po',
    'delivery_date',
    'cara_pembayaran',
    'term_from',
    'term_to',
    'lama_hari',
    'jenis_pembayaran',
    'shipment',
    'suplier_id',
    'lokasi_pengiriman',
    'sub_total',
    'tax',
    'freight_cost',
    'total',
    'dp',
    'jml_dp',
    'catatan',
    'kode_proyek',
    'prepared_by',
    'status_bsd',
    'validasi_bsd',
    'status_dir_keuangan',
    'approved_by',
    'prepared_by_name',
    'validasi_bsd_name',
    'approved_by_name',
    'suplier_name',
    'detail',
  ]);
  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
  RxList<FormManager> formRabs = RxList([]);

  List<PoPpn> listData = [];
  RxList<PoPpn> datas = <PoPpn>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final id = Get.parameters['id'];

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.poPpn.getDataBelumValidasi(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listData = PoPpn.fromJsonList(res.data);

      datas.value = listData;
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
    if (data != null) {
      forms.fill(data!.toJson());
    }
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
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
      final res =
          await api.poPpn.getDataBelumValidasi({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = PoPpn.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void updateData(PoPpn data, String id) {
    try {
      final controller = Get.find<PoPpnLogistikBelumValidasiController>();
      int index = controller.datas.indexWhere((e) => e.id == data.id);

      logg('--- index: $index');

      if (index != -1) {
        controller.datas[index] = data;
        controller.isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future deleteData(String noHide) async {
    try {
      final res = await api.poPpn.deleteData(noHide).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listData.removeWhere((e) => e.noHide == noHide);
      isLoading.refresh();
      Get.snackbar('Berhasil', res.message ?? '');
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
      final res = await api.poPpn
          .getDataBelumValidasi({...query, 'search': searchC.text});
      final data = PoPpn.fromJsonList(res.data);
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
// PengajuanLogistik details = PengajuanLogistik();
// RxList<DetailPengajuanLogistik> cards = RxList([]);

// Future getDetails(PengajuanLogistik data) async {
//   try {
//     String nohide = data.noHide ?? '';
//     final res = await api.pengajuanGlobal.getDatalogistikByNoHide(nohide);
//     details = PengajuanLogistik.fromJson(res.data ?? {});
//     cards.value = details.detail ?? [];
//   } catch (e, s) {
//     Errors.check(e, s);
//   }
// }

// void insertData(PengajuanLogistik data) {
//   try {
//     final controller = Get.find<PengajuanLogistikBelumValidasiController>();
//     controller.pengajuan.insert(0, data);
//     controller.isLoading.refresh();
//   } catch (e, s) {
//     Errors.check(e, s);
//   }
// }

// void updateData(PengajuanLogistik data, String noHide) {
//   try {
//     int index = listData.indexWhere((e) => e.noHide == noHide);
//     if (index >= 0) {
//       listData[index] = data;
//       pengajuan.value = List.from(listData);

//       isLoading.refresh();
//     }
//   } catch (e, s) {
//     Errors.check(e, s);
//   }
// }
