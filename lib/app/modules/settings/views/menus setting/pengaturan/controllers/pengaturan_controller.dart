import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PengaturanController extends GetxController {
  var isDarkMode = false.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    isDarkMode.value = false;
  }

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }
}
