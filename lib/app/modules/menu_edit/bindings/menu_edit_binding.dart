import 'package:get/get.dart';

import '../controllers/menu_edit_controller.dart';

class MenuEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuEditController>(
      () => MenuEditController(),
    );
  }
}
