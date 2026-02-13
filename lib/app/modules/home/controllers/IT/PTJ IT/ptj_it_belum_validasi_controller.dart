import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20it/ptj_it/ptj_it.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class PtjItBelumValidasiController extends GetxController with Apis {
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;

  List<PtjIt> listPtj = [];
  RxList<PtjIt> pengajuan = <PtjIt>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final id = Get.parameters['id'];

  Future getData() async {
    try {
      ListItemAnimasi.animatedItems.clear();

      page = 1;
      isLoading.value = true;
      final res = await api.ptjGlobal.getDataBelumPtjIt(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listPtj = PtjIt.fromJsonList(res.data);

      pengajuan.value = listPtj;
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
      final res =
          await api.ptjGlobal.getDataBelumPtjIt({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listPtj = PtjIt.fromJsonList(res.data);
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

  void insertData(PtjIt data) {
    listPtj.insert(0, data);
    isLoading.refresh();
  }

  void updateData(PtjIt data, int id) {
    try {
      int index = listPtj.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listPtj[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listPtj.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.ptjGlobal
          .getDataBelumPtjIt({...query, 'search': searchC.text});
      final data = PtjIt.fromJsonList(res.data);
      listPtj.addAll(data);
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
