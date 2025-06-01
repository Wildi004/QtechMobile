import 'package:get/get.dart';

import '../controllers/data_mandor_controller.dart';

class DataMandorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataMandorController>(
      () => DataMandorController(),
    );
  }
}
