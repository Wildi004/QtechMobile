import 'package:get/get.dart';

import '../controllers/daftar_tkdn_controller.dart';

class DaftarTkdnBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaftarTkdnController>(
      () => DaftarTkdnController(),
    );
  }
}
