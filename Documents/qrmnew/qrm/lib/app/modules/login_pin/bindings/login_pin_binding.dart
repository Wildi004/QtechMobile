import 'package:get/get.dart';

import '../controllers/login_pin_controller.dart';

class LoginPinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginPinController>(
      () => LoginPinController(),
    );
  }
}
