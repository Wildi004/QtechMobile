import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/pengajuan_dep_bsd/pengajuan_dep_bsd.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class PengajuanDevBsdBelumController extends GetxController with Apis {
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;

  RxBool isLoading = true.obs; //
  var isExpanded = false.obs;

  List<PengajuanDepBsd> listPengajuan = [];
  RxList<PengajuanDepBsd> pengajuan = <PengajuanDepBsd>[].obs; //

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  final id = Get.parameters['id'];

  Future getData() async {
    try {
      ListItemAnimasi.animatedItems.clear();

      page = 1;
      isLoading.value = true;
      final res = await api.pengajuanDepBsd.getDataBelumVal(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listPengajuan = PengajuanDepBsd.fromJsonList(res.data);

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
      final res = await api.pengajuanDepBsd
          .getDataBelumVal({...query, 'search': value});
      total = res.body?['pagination']?['total_records'] ?? 0;
      listPengajuan = PengajuanDepBsd.fromJsonList(res.data);
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

  // void updateData(PengajuanIt data, String id) {
  //   try {
  //     final controller = Get.find<PengajuanItBelumValidasiController>();
  //     int index = controller.pengajuan.indexWhere((e) => e.id == data.id);

  //     logg('--- index: $index');

  //     if (index != -1) {
  //       controller.pengajuan[index] = data;
  //       controller.isLoading.refresh();
  //     }
  //   } catch (e, s) {
  //     Errors.check(e, s);
  //   }
  // }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listPengajuan.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.pengajuanDepBsd
          .getDataBelumVal({...query, 'search': searchC.text});
      final data = PengajuanDepBsd.fromJsonList(res.data);
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
