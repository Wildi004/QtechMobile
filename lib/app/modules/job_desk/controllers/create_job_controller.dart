import 'dart:io';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/job_desk.dart';

class CreateJobController extends GetxController with Apis {
  final forms = LzForm.make(['image', 'role_id']);

  File? file;
  RxString fileName = ''.obs;
  RxBool isLoading = true.obs;
  List<JobDesk> listJd = [];
  RxList<JobDesk> rxJd = <JobDesk>[].obs;
  Rxn<JobDesk> jobDesk = Rxn<JobDesk>();

  List<Map<String, dynamic>> roles = [];
  int page = 1, total = 0;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};

  Future onSelectRole() async {
    try {
      page = 1;
      isLoading.value = true;

      if (roles.isEmpty) {
        final res = await api.role.getData(query).ui.loading();
        total = res.body?['pagination']?['total_records'] ?? 0;
        listJd = JobDesk.fromJsonList(res.data);

        roles = List<Map<String, dynamic>>.from(res.data ?? []);
      }

      // set data ke select options
      forms.set('role_id').options(roles.labelValue('role', 'id'));
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future onSubmit([int? id]) async {
    try {
      final form = forms.validate(required: ['*', 'role_id']);
      if (form.ok) {
        final payload = form.value;

        logg(form.error);

        if (file != null) {
          payload['image'] = await api.toFile(file!.path);
        }

        // ketika submit/request api dan ingin mengambil nilai id dari select option
        // lakukan cara ini
        payload['role_id'] = forms.extra('role_id');

        if (id == null) {
          final res = await api.jobDesk
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
          }
        } else {
          final res = await api.jobDesk
              .updateData(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data);
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
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
}
