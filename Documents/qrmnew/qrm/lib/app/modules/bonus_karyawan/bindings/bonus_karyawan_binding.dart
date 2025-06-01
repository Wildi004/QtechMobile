import 'package:get/get.dart';

import '../controllers/bonus_karyawan_controller.dart';

class BonusKaryawanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BonusKaryawanController>(
      () => BonusKaryawanController(),
    );
  }
}
