import 'package:get/get.dart';

import '../controllers/standar_teknik_controller.dart';

class StandarTeknikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StandarTeknikController>(
      () => StandarTeknikController(),
    );
  }
}
