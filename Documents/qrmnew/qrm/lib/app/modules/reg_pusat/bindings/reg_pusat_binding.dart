import 'package:get/get.dart';

import '../controllers/reg_pusat_controller.dart';

class RegPusatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegPusatController>(
      () => RegPusatController(),
    );
  }
}
