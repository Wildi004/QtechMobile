import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/rab_logistik/rab_logistik.dart';
import 'package:qrm_dev/app/data/services/filter_mount_rab_it.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Rab%20logistik/rab_logistik_belum_validasi_controller.dart';

class RabLogistikController extends GetxController with Apis {
  RxString searchQuery = "".obs;
  RxInt tab = 0.obs;
  RxString orderDir = 'asc'.obs;

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;

  List<RabLogistik> listrab = [];
  RxList<RabLogistik> rab = <RabLogistik>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {
        'page': page,
        'per_page': 10,
        'order_dir': orderDir.value,
      };

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.rabGlobal.getValidasiLogistik(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listrab = RabLogistik.fromJsonList(res.data);

      rab.value = listrab;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future getDatabelumValidasi() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.rabGlobal.getBelumValidasiLogistik(query);
      total = res.body?['pagination']?['total_records'] ?? 0;

      listrab = RabLogistik.fromJsonList(res.data);

      rab.value = listrab;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Map<String, List<RabLogistik>> get rabGroupedByBulan {
    Map<String, List<RabLogistik>> grouped = {};

    for (var item in rab) {
      final label = item.bulanTahunLabel;

      if (!grouped.containsKey(label)) {
        grouped[label] = [];
      }

      grouped[label]!.add(item);
    }

    return grouped;
  }

  Future<void> onSubmit() async {
    try {} catch (e, s) {
      Toast.dismiss();
      Errors.check(e, s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    rab.value = listrab
        .where((data) =>
            data.kodeRab?.toLowerCase().contains(searchQuery.value) ?? false)
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

  void insertData(RabLogistik data) {
    try {
      final controller = Get.find<RabLogistikBelumValidasiController>();

      controller.listrab.insert(0, data);

      controller.isLoading.refresh();
      logg('testing');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateData(RabLogistik data, int id) {
    try {
      int index = listrab.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listrab[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listrab.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.rabGlobal.getDatalogistik(query);
      final data = RabLogistik.fromJsonList(res.data);
      listrab.addAll(data);
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
