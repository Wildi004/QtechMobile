import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/role_akses/sub_menu.dart';

class AllSubMenuController extends GetxController {
  final RxList<SubMenu> menus = <SubMenu>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initMenus();
  }

  void setMenus(List<SubMenu> data) {
    menus.assignAll(data);
  }

  void _initMenus() {
    menus.assignAll([
      SubMenu(name: 'Dashboard Umum', icon: Icons.dashboard),
      SubMenu(
        name: 'Anggaran Departemen',
        icon: 'assets/icons/anggaran.png',
        isAsset: true,
      ),
      SubMenu(
        name: 'Monitoring Proyek',
        icon: Hi.chair01,
      ),
      SubMenu(
        name: 'Notulen',
        icon: 'assets/icons/notulen.png',
        isAsset: true,
      ),
    ]);
  }

  /// handler ketika menu ditekan
  void onMenuTap(SubMenu e) {
    switch (e.name) {
      case 'Dashboard Umum':
        Get.snackbar('Info', 'Sedang Tahap Pengembangan');
        break;
      default:
        Get.snackbar('Info', '${e.name} belum tersedia');
    }
  }
}
