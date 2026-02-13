import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/po_non/po_non.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Po%20Non%20Ppn/po_non_belum_validasi_controller.dart';

class PoNonControllerr extends GetxController with Apis {
  PoNon? data;
  final isFilled = false.obs;
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;
  final forms = LzForm.make([
    'id',
    'no_po_nonppn',
    'tgl_po',
    'tgl_dikirim',
    'cara_pembayaran',
    'term_from',
    'term_to',
    'lama_hari',
    'suplier_id',
    'sub_total',
    'freight_cost',
    'total',
    'dp',
    'jml_dp',
    'catatan',
    'prepared_by',
    'status_bsd',
    'validasi_bsd',
    'approved_by',
    'status_dir_keuangan',
    'user_session',
    'created_at',
    'no_hide',
    'prepared_by_name',
    'user_session_name',
    'validasi_bsd_name',
    'approved_by_name',
    'suplier_name',
  ]);

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
  RxList<FormManager> formRabs = RxList([]);

  List<PoNon> listData = [];
  RxList<PoNon> datas = <PoNon>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final id = Get.parameters['id'];

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.poNon.getData(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listData = PoNon.fromJsonList(res.data);

      datas.value = listData;
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
      final res = await api.poNon.getData({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = PoNon.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void insertData(PoNon data) {
    try {
      final controller = Get.find<PoNonBelumValidasiController>();
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
      final res = await api.poNon.getData({...query, 'search': searchC.text});
      final data = PoNon.fromJsonList(res.data);
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
