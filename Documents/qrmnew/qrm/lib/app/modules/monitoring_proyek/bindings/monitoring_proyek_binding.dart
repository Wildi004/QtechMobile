import 'package:get/get.dart';

import '../controllers/monitoring_proyek_controller.dart';

class MonitoringProyekBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MonitoringProyekController>(
      () => MonitoringProyekController(),
    );
  }
}
