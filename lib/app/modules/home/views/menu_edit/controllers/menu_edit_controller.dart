import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/views/menu_edit/controllers/menu_navigasi_controller.dart';

class MenuEditController extends GetxController {
  RxBool isEditing = false.obs;

  RxList<Map<String, dynamic>?> favoriteMenus =
      List<Map<String, dynamic>?>.filled(10, null, growable: false).obs;

  RxList<Map<String, dynamic>> otherMenus = <Map<String, dynamic>>[].obs;
  final navigator = MenuNavigasiController();
  final _draggingIndex = Rxn<int>();
  int? get draggingIndex => _draggingIndex.value;

  @override
  void onInit() {
    super.onInit();

    final defaultFavorites = [
      {
        'label': 'Kasbon',
        'color': '5D688A'.hex,
        'icon': 'assets/images/kasbon.png',
        'route': 'kasbon'
      },
      {
        'label': 'Capaian Kinerja',
        'color': '4CA1AF'.hex,
        'icon': 'assets/images/images2/graph01.png',
        'route': 'capaian_kinerja',
      },
      {
        'label': 'Modal Logistik',
        'color': '9f68dd'.hex,
        'icon': 'assets/images/images2/price01.png',
        'route': 'modal_logistik'
      },
      {
        'label': 'Notulen',
        'color': '467bf6'.hex,
        'icon': 'assets/images/images2/note01.png',
        'route': 'notulen'
      },
    ];

    favoriteMenus
        .assignAll([...defaultFavorites, null, null, null, null, null, null]);

    otherMenus.assignAll([
      {
        'label': 'Anggaran Departemen',
        'icon': 'assets/images/images2/chart01.png',
        'color': Colors.deepPurple,
        'route': 'anggaran_departemen'
      },
      {
        'label': 'Monitoring Project',
        'icon': 'assets/images/monitorSeo.png',
        'color': Colors.indigo,
        'route': 'monitoring_project'
      },
      {
        'label': 'Brosur Logistik',
        'icon': 'assets/images/brosur01.png',
        'color': Colors.pink,
        'route': 'brosur_logistik'
      },
      {
        'label': 'Daftar TKDN',
        'icon': 'assets/images/listDock01.png',
        'color': Colors.amber,
        'route': 'daftar_tkdn'
      },
      {
        'label': 'Surat Internal',
        'icon': 'assets/images/mail01.png',
        'color': Colors.blueAccent,
        'route': 'surat_internal'
      },
      {
        'label': 'Job Desk',
        'icon': 'assets/images/jobs01.png',
        'color': Colors.teal,
        'route': 'job_desk'
      },
      {
        'label': 'SK Direksi',
        'icon': 'assets/images/fileInfo01.png',
        'color': Colors.green,
        'route': 'sk_direksi'
      },
      {
        'label': 'Data Mandor',
        'icon': 'assets/images/worker01.png',
        'color': Colors.lightBlue,
        'route': 'data_mandor'
      },
      {
        'label': 'Panduan Instalasi',
        'icon': 'assets/images/bookHand01.png',
        'color': Colors.lightGreen,
        'route': 'panduan_instalasi'
      },
      {
        'label': 'Pengumuman',
        'icon': 'assets/images/bookHand01.png',
        'color': Colors.lightGreen,
        'route': 'pengumuman'
      },
      {
        'label': 'Standarisai Teknik',
        'icon': 'assets/images/bookHand01.png',
        'color': Colors.lightGreen,
        'route': 'Standar_teknik'
      },
    ]);
  }

  void toggleEditing() => isEditing.toggle();

  void removeFromFavorite(int index) {
    final removed = favoriteMenus[index];
    if (removed != null) {
      favoriteMenus[index] = null;
      otherMenus.add(removed);
    }
  }

  void removeFromFavoriteByItem(Map<String, dynamic> item) {
    final index = favoriteMenus.indexOf(item);
    if (index != -1) {
      favoriteMenus[index] = null;
      otherMenus.add(item);
      favoriteMenus.refresh();
      otherMenus.refresh();
    }
  }

  void addToFavorite(int index) {
    if (!favoriteMenus.any((e) => e == null)) {
      Get.defaultDialog(
        title: 'Maksimal 10 Menu',
        middleText: 'Hanya bisa memilih maksimal 10 slot favorit.',
      );
      return;
    }

    final added = otherMenus.removeAt(index);
    final firstEmptyIndex = favoriteMenus.indexOf(null);
    favoriteMenus[firstEmptyIndex] = added;
  }

  void navigateTo(String routeKey) {
    navigator.navigateTo(routeKey);
  }

  void onDragStarted(int index) => _draggingIndex.value = index;

  void onDragEnd() => _draggingIndex.value = null;

  void reorderFavorite(int oldIndex, int newIndex) {
    if (oldIndex < 0 ||
        oldIndex >= favoriteMenus.length ||
        newIndex < 0 ||
        newIndex > favoriteMenus.length) {
      onDragEnd();
      return;
    }

    if (oldIndex < newIndex) newIndex -= 1;

    final draggedItem = favoriteMenus.removeAt(oldIndex);
    favoriteMenus.insert(newIndex, draggedItem);
    favoriteMenus.refresh();
    onDragEnd();
  }
}
