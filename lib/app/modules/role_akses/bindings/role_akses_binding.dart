import 'package:get/get.dart';

import '../controllers/role_akses_controller.dart';

class RoleAksesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleAksesController>(
      () => RoleAksesController(),
    );
  }
}
