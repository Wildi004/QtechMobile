import 'package:get/get.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_absen_controller/building/form_building_hrd_controller.dart';

class FormBuildingHrdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormBuildingHrdController>(() => FormBuildingHrdController());
  }
}
