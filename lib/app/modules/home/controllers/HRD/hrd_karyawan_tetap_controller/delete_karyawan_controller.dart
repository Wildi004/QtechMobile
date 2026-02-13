import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/daftar_tkdn.dart';

class DeleteKaryawanController extends GetxController with Apis {
  RxBool isLoading = true.obs;
  var isExpanded = false.obs;

  List<DaftarTkdn> karyawanList = [];
  RxList<DaftarTkdn> karyawan = <DaftarTkdn>[].obs;

  Future deleteKaryawan(int id) async {
    try {
      final res =
          await api.karyawanTetap.deleteData(id).ui.loading('Menghapus...');
      if (!res.status) {
        return Toast.error(res.message);
      }
      karyawanList.removeWhere((e) => e.id == id);

      isLoading.refresh();

      Get.snackbar('Berhasil', res.message ?? ' ');
      Get.back(result: res.data);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future onPageInit() async {
    try {} catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }
}
