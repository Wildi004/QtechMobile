import 'package:get/get.dart';
import 'package:qrm_dev/app/modules/capaian_kinerja/controllers/capaian%20kinerja1/capaian_kerja1_controller.dart';

class CapaianKinerjaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CapaianKerja1Controller>(
      () => CapaianKerja1Controller(),
    );
  }
}
