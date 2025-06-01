import 'package:get/get.dart';

import '../controllers/capaian_controller.dart';

class CapaianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CapaianControsller>(
      () => CapaianControsller(),
    );
  }
}
