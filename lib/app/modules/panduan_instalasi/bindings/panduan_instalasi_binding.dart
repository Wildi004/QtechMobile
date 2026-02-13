import 'package:get/get.dart';

import '../controllers/panduan_instalasi_controller.dart';

class PanduanInstalasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PanduanInstalasiController>(
      () => PanduanInstalasiController(),
    );
  }
}
