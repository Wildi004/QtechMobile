import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/shift_building/shift.dart';

class ShiftHrdController extends GetxController with Apis {
  final forms = LzForm.make([
    'shift_id',
    'shift_name',
    'time_in',
    'time_out',
  ]);
  RxString searchQuery = "".obs;
  RxBool isLoading = true.obs;
  var isExpanded = false.obs;

  List<Shifts> listShift = [];
  RxList<Shifts> shift = <Shifts>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getData() async {
    try {
      page = 1;
      isLoading.value = true;
      final res = await api.shift.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listShift = Shifts.fromJsonList(res.data);
      shift.value = listShift;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future delete(int id) async {
    try {
      final res = await api.shift.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listShift.removeWhere((e) => e.shiftId == id);

      isLoading.refresh();

      Get.snackbar(
        'Berhasil',
        res.message ?? '',
      );
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();

    for (var data in listShift) {
      logg('Deskripsi: ${data.shiftId}');
    }

    shift.value = listShift
        .where((data) =>
            data.shiftName?.toLowerCase().contains(searchQuery.value) ?? false)
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

  void insertData(Shifts data) {
    listShift.insert(0, data);
    isLoading.refresh();
  }

  void updateData(Shifts data, int id) {
    try {
      int index = listShift.indexWhere((e) => e.shiftId == id);
      if (index >= 0) {
        listShift[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listShift.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.shift.getData(query);
      final data = Shifts.fromJsonList(res.data);
      listShift.addAll(data);
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
