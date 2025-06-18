import 'package:get/get.dart';

import '../controllers/buku_bank_controller.dart';

class BukuBankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BukuBankController>(
      () => BukuBankController(),
    );
  }
}
