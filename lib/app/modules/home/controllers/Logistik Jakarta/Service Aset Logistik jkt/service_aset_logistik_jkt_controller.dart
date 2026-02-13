import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/service_aset/service_aset.dart';

class ServiceAsetLogistikJktController extends GetxController with Apis {
  final forms = LzForm.make([
    'id',
    'jenis_aset',
    'kode_aset',
    'tgl_service',
    'tempat_service',
    'biaya',
    'keterangan',
    'nota',
    'created_at',
    'created_by_name',
    'diservice_oleh_name',
    'aset_name',
  ]);

  RxBool isLoading = true.obs;
  RxString searchQuery = "".obs;
  var isExpanded = false.obs;

  List<ServiceAset> listData = [];
  RxList<ServiceAset> datas = <ServiceAset>[].obs;
  int page = 1, total = 0;

  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.serviceAset.getDataJkt(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listData = ServiceAset.fromJsonList(res.data);
      datas.value = listData;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    datas.value = listData
        .where((datas) =>
            datas.jenisAset?.toLowerCase().contains(searchQuery.value) ?? false)
        .toList();
  }

  Future onPageInit() async {
    try {
      await getData();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateData(ServiceAset data, int id) {
    try {
      final controller = Get.find<ServiceAsetLogistikJktController>();
      int index = controller.datas.indexWhere((e) => e.id == id);

      logg('test');

      logg('--- index: $index');

      if (index != -1) {
        controller.datas[index] = data;
        controller.datas.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void insertData(ServiceAset data) {
    listData.insert(0, data);
    isLoading.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  Future deleteData(int id) async {
    try {
      final res =
          await api.serviceAset.deleteDataJkt(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listData.removeWhere((e) => e.id == id);
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
      final res = await api.serviceAset.getDataJkt(query);
      final data = ServiceAset.fromJsonList(res.data);
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
