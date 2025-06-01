import 'package:get/get.dart';

import '../controllers/capaian_kinerja_controller.dart';

class CapaianKinerjaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CapaianKinerjaController>(
      () => CapaianKinerjaController(),
    );
  }
}
