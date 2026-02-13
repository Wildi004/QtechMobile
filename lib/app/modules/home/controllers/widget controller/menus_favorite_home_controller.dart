// lib/app/modules/home/controllers/home_controller.dart

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/modules/capaian_kinerja/views/capaian_kerja1/capaian_kerja1_view.dart';
import 'package:qrm_dev/app/modules/harga_modal_logistik/views/harga_modal_logistik_view.dart';
import 'package:qrm_dev/app/modules/kasbon/views/kasbon_view.dart';
import 'package:qrm_dev/app/routes/app_pages.dart';

class MenusFavoriteHomeController extends GetxController {
  final _menuItems = <Map<String, dynamic>>[
    {
      'label': 'Kasbon',
      'color': '5D688A'.hex,
      'icon': Hi.note,
      'route': () =>
          Get.to(() => KasbonView(), transition: Transition.rightToLeft)
    },
    {
      'label': 'Capaian Kinerja',
      'color': '4CA1AF'.hex,
      'icon': Hi.chartLineData01,
      'route': () => Get.context!.openBottomSheet(CapaianKerja1View())
    },
    {
      'label': 'Modal Logistik',
      'color': '9f68dd'.hex,
      'icon': Hi.note01,
      'route': () =>
          Get.to(() => HargaModalLogistikView(), transition: Transition.fade)
    },
    {
      'label': 'Notulen',
      'color': '467bf6'.hex,
      'icon': Hi.fileAttachment,
      'route': () => Get.toNamed(Routes.NOTULEN)
    },
  ].obs;

  final _draggingIndex = Rxn<int>();
  int? get draggingIndex => _draggingIndex.value;

  void onDragStarted(int index) {
    _draggingIndex.value = index;
  }

  void onDragEnd() {
    _draggingIndex.value = null;
  }

  void reorderItems(int oldIndex, int newIndex) {
    if (oldIndex < 0 ||
        oldIndex >= _menuItems.length ||
        newIndex < 0 ||
        newIndex > _menuItems.length) {
      onDragEnd();
      return;
    }

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final draggedItem = _menuItems.removeAt(oldIndex);
    _menuItems.insert(newIndex, draggedItem);

    _menuItems.refresh(); // Memicu rebuild UI untuk RxList
    onDragEnd(); // Reset dragging state setelah data diperbarui
  }

  void navigateTo(Function routeAction) {
    routeAction();
  }
}
