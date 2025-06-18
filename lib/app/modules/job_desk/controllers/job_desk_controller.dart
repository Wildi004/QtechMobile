import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/extensions.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/job_desk.dart';

class JobDeskController extends GetxController with Apis {
  RxString searchQuery = "".obs;
  RxBool isLoading = true.obs;
  var isExpanded = false.obs;

  List<JobDesk> listJd = [];
  RxList<JobDesk> rxJd = <JobDesk>[].obs;

  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future getJob() async {
    try {
      page = 1;

      isLoading.value = true;
      final res = await api.jobDesk.getData(query);

      total = res.body?['pagination']?['total_records'] ?? 0;
      listJd = JobDesk.fromJsonList(res.data);
      rxJd.value = listJd;
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future deletetJob(int id) async {
    try {
      final res = await api.jobDesk.deletetJob(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listJd.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Toast.success('Data berhasil dihapus');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    rxJd.value = listJd
        .where((jobDesk) =>
            jobDesk.roleName?.toLowerCase().contains(searchQuery.value) ??
            false)
        .toList();
  }

  Future onPageInit() async {
    try {
      await getJob();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getJob();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }

  void insertData(JobDesk data) {
    listJd.insert(0, data);
    isLoading.refresh();
  }

  void updateData(JobDesk data, int id) {
    try {
      int index = listJd.indexWhere((e) => e.id == id);
      if (index >= 0) {
        listJd[index] = data;
        isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  RxBool isPaginate = false.obs;

  Future onPaginate() async {
    try {
      if (listJd.length >= total || isPaginate.value) {
        return;
      }

      page++;
      isPaginate.value = true;
      final res = await api.jobDesk.getData(query);
      final data = JobDesk.fromJsonList(res.data);
      listJd.addAll(data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      Utils.timer(() {
        isPaginate.value = false;
        isLoading.refresh();
      }, 1.s);
    }
  }

  Future delete(int id) async {
    try {
      final res = await api.jobDesk.deletetJob(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      listJd.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Toast.success('Data berhasil dihapus');
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
