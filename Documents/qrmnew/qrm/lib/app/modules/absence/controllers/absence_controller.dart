import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/user.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class AbsenceController extends GetxController with Apis {
  var isSnackbarVisible = false.obs;
  final ScrollController scrollController = ScrollController();
  RxBool isLoading = true.obs;
  Rxn<User> user = Rxn<User>();

  List<User> users = [];
  int page = 1;
  Map<String, dynamic> get query => {'page': page, 'per_page': 10};
  List<Map<String, dynamic>> absensiData = [
    {
      "bulan": "Februari",
      "data": [
        {'tanggal': 'Senin, 10 Februari 2025', 'status': 'Normal'},
        {'tanggal': 'Sabtu, 8 Februari 2025', 'status': 'Sakit'},
        {'tanggal': 'Jumat, 7 Februari 2025', 'status': 'Izin'},
        {'tanggal': 'Kamis, 6 Februari 2025', 'status': 'Normal'},
        {'tanggal': 'Rabu, 5 Februari 2025', 'status': 'Terlambat'},
        {'tanggal': 'Selasa, 4 Februari 2025', 'status': 'Normal'},
        {'tanggal': 'Senin, 3 Februari 2025', 'status': 'Normal'},
        {'tanggal': 'Sabtu, 1 Februari 2025', 'status': 'Terlambat'},
      ]
    },
    {
      "bulan": "Januari",
      "data": [
        {'tanggal': 'Senin, 10 Januari 2025', 'status': 'Normal'},
        {'tanggal': 'Sabtu, 8 Januari 2025', 'status': 'Normal'},
        {'tanggal': 'Jumat, 7 Januari 2025', 'status': 'Normal'},
        {'tanggal': 'Kamis, 6 Januari 2025', 'status': 'Normal'},
        {'tanggal': 'Rabu, 5 Januari 2025', 'status': 'Terlambat'},
        {'tanggal': 'Selasa, 4 Januari 2025', 'status': 'Normal'},
        {'tanggal': 'Senin, 3 Januari 2025', 'status': 'Normal'},
        {'tanggal': 'Sabtu, 1 Januari 2025', 'status': 'Terlambat'},
      ]
    },
  ];

  void showSnackbar() {
    if (!isSnackbarVisible.value) {
      isSnackbarVisible.value = true;
      Get.snackbar('Absen Pulang', 'Berhasil Absen Pulang');

      Future.delayed(const Duration(seconds: 4), () {
        isSnackbarVisible.value = false;
      });
    }
  }

  Future<void> getUserLogged() async {
    try {
      isLoading.value = true;
      final auth = await Auth.user();
      final res = await api.user.getData(auth.id!);
      user.value = User.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onPageInit() async {
    try {
      await getUserLogged();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    onPageInit();
  }
}
