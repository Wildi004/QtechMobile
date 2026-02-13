import 'package:get/get.dart';

import '../controllers/anggaran_departemen_controller.dart';

class AnggaranDepartemenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnggaranDepartemenController>(
      () => AnggaranDepartemenController(),
    );
  }
}
