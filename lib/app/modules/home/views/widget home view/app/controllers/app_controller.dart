import 'package:get/get.dart';
import 'package:qrm_dev/app/modules/absence/controllers/absence_controller.dart';
import 'package:qrm_dev/app/modules/settings/controllers/settings_controller.dart';

class AppController extends GetxController {
  RxBool isLogged = false.obs;
  RxBool showSplash = true.obs;
  RxInt navIndex = 0.obs;
  RxInt pressedIndex = (-1).obs;
  List<int> visited = [0];

  void onNavigate(int index) {
    navIndex.value = index;

    if (index == 1) {
      // 1 = index Absen
      final c = Get.find<AbsenceController>();
      c.onPageInit();
    }

    visited.addIf(!visited.contains(index), index);
  }

  @override
  void onInit() {
    super.onInit();

    ever(navIndex, (index) {
      if (index == 3) {
        // 3 = index halaman SettingsView
        final controller = Get.find<SettingsController>();
        controller.getDataCuti();
      }
    });
  }
}
