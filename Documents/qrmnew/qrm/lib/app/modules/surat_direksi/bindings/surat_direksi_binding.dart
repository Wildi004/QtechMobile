import 'package:get/get.dart';

import '../controllers/surat_direksi_controller.dart';

class SuratDireksiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuratDireksiController>(
      () => SuratDireksiController(),
    );
  }
}
