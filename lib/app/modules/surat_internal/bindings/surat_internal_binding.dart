import 'package:get/get.dart';

import '../controllers/surat_internal_controller.dart';

class SuratInternalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuratInternalController>(
      () => SuratInternalController(),
    );
  }
}
