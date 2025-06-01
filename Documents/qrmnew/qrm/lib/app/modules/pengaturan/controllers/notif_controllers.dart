import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class NotifControllers extends GetxController {
  final _box = GetStorage();
  final _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  @override
  void onInit() {
    // ambil preferensi tersimpan, default system
    final saved = _box.read('themeMode') ?? 'system';
    _themeMode.value = _decode(saved);
    super.onInit();
  }

  void toggleTheme(bool isDark) {
    _themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
    _box.write('themeMode', _encode(_themeMode.value));
    update(); // update GetBuilder/Obx
  }

  void useSystem() {
    _themeMode.value = ThemeMode.system;
    _box.write('themeMode', 'system');
    update();
  }

  // helper encode/decode
  String _encode(ThemeMode m) => m == ThemeMode.dark
      ? 'dark'
      : m == ThemeMode.light
          ? 'light'
          : 'system';
  ThemeMode _decode(String s) => s == 'dark'
      ? ThemeMode.dark
      : s == 'light'
          ? ThemeMode.light
          : ThemeMode.system;
}
