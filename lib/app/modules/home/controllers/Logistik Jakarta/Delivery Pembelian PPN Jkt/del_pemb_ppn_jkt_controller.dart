import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_pemb_ppn/del_pemb_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Delivery%20Pembelian%20PPN%20Logistik/del_pemb_ppn_belum_val_controller.dart';

class DelPembPpnJktController extends GetxController with Apis {
  DelPembPpn? data;
  final isFilled = false.obs;
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;
  final forms = LzForm.make([
    'id',
    'no_delivery',
    'no_pembelian',
    'shipment_date',
    'received_date',
    'ekspedisi',
    'penerima',
    'lokasi_pengiriman',
    'total_berat',
    'harga_ekspedisi',
    'created_by',
    'approval',
    'status_gm_regional',
    'approved_by',
    'status_dir_keuangan',
    'created_at',
    'no_hide',
    'created_by_name',
    'approval_name',
    'approved_by_name',
  ]);

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
  RxList<FormManager> formRabs = RxList([]);

  List<DelPembPpn> listData = [];
  RxList<DelPembPpn> datas = <DelPembPpn>[].obs;
  RxList<DelPembPpn> datapo = <DelPembPpn>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final id = Get.parameters['id'];

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.delPembPpn.getDataJkt(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listData = DelPembPpn.fromJsonList(res.data);

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
      final res = await api.delPembPpn.getDataJkt({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = DelPembPpn.fromJsonList(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void insertData(DelPembPpn data) {
    try {
      final controller = Get.find<DelPembPpnBelumValController>();
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
      final res =
          await api.delPembPpn.getDataJkt({...query, 'search': searchC.text});
      final data = DelPembPpn.fromJsonList(res.data);
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
