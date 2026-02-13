import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_po_non_ppn/del_po_non_ppn.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_po_non_ppn/detail.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Del%20PO%20Non%20PPN/del_po_non_belum_validasi_controller.dart';

class DelPoNonController extends GetxController with Apis {
  DelPoNonPpn? data;
  final isFilled = false.obs;
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;
  final forms = LzForm.make([
    'id',
    'no_delivery',
    'no_po',
    'shipment_date',
    'received_date',
    'lokasi_kirim',
    'penerima',
    'ekspedisi',
    'total_berat',
    'harga_ekspedisi',
    'created_by',
    'approval',
    'status_gm_regional',
    'approved_by',
    'status_dir_keuangan',
    'approval_name',
    'approved_by_name',
  ]);

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
  RxList<FormManager> formRabs = RxList([]);

  List<DelPoNonPpn> listData = [];
  RxList<DelPoNonPpn> datas = <DelPoNonPpn>[].obs;
  RxList<DelPoNonPpn> datapo = <DelPoNonPpn>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final id = Get.parameters['id'];

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.delPoNonPpn.getData(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listData = DelPoNonPpn.fromJsonList(res.data);

      datas.value = listData;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  DelPoNonPpn details = DelPoNonPpn();
  RxList<DetailDelPoNon> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();
  final detailOrangList = <DetailDelPoNon>[].obs;

  void fillFormDetails(List<DetailDelPoNon>? orang) {
    formDetails.clear();
    detailOrangList.clear();

    if (orang != null) {
      for (var e in orang) {
        final form = LzForm.make([
          'kode',
          'qty',
          'namabarang',
          'jumlahKeluar',
          'beratSatuan',
          'total'
        ]);
        form.fill({
          'kode': e.kodeMaterial ?? '',
          'qty': e.qty ?? '',
          'namabarang': e.namaBarang ?? '',
          'jumlahKeluar': e.jumlahKeluar ?? '',
          'beratSatuan': e.beratSatuan ?? '',
          'total': e.total ?? '',
        });

        formDetails.add(form);
        detailOrangList.add(e);
      }
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
      final res = await api.delPoNonPpn.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = DelPoNonPpn.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void insertData(DelPoNonPpn data) {
    try {
      final controller = Get.find<DelPoNonBelumValidasiController>();
      controller.datas.insert(0, data);
      controller.isLoading.refresh();
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
      final res = await api.hrdCuti.getData({...query, 'search': searchC.text});
      final data = DelPoNonPpn.fromJsonList(res.data);
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
}
