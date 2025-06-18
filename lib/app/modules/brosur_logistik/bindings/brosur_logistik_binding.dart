import 'package:get/get.dart';

import '../controllers/brosur_logistik_controller.dart';

class BrosurLogistikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrosurLogistikController>(
      () => BrosurLogistikController(),
    );
  }
}
