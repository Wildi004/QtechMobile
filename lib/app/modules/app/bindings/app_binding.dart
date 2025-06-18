import 'package:get/get.dart';
import 'package:qrm/app/modules/absence/controllers/absence_controller.dart';
import 'package:qrm/app/modules/home/controllers/home_controller.dart';
import 'package:qrm/app/modules/product/controllers/product_controller.dart';
import 'package:qrm/app/modules/settings/controllers/settings_controller.dart';

import '../../login/controllers/login_controller.dart';
import '../controllers/app_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<AppController>(
      () => AppController(),
    );
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AbsenceController>(() => AbsenceController());
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
