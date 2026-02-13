import 'package:get/get.dart';
import 'package:qrm_dev/app/modules/absence/controllers/absence_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/home_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menu_edit/controllers/menu_edit_controller.dart';
import 'package:qrm_dev/app/modules/product/controllers/product_controller.dart';
import 'package:qrm_dev/app/modules/settings/controllers/settings_controller.dart';

import '../../../../../login/controllers/login_controller.dart';
import '../controllers/app_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<AppController>(
      () => AppController(),
    );
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MenuEditController>(() => MenuEditController());
    Get.lazyPut<AbsenceController>(() => AbsenceController());
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
