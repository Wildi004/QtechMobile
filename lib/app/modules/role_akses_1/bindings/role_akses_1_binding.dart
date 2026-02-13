import 'package:get/get.dart';

import '../controllers/role_akses_1_controller.dart';

class RoleAkses1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleAkses1Controller>(
      () => RoleAkses1Controller(),
    );
  }
}
