import 'package:get/get.dart';
import 'package:qrm_dev/app/modules/home/controllers/widget%20controller/event_home_view_vontroller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.put(EventHomeViewVontroller());
  }
}
