import 'package:get/get.dart';

import '../controllers/harga_modal_logistik_controller.dart';

class HargaModalLogistikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HargaModalLogistikController>(
      () => HargaModalLogistikController(),
    );
  }
}
