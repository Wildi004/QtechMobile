import 'package:get/get.dart';
import 'package:qrm_dev/app/modules/home/controllers/home_controller.dart';

class DirBsdController extends GetxController {
  final HomeController homeC = Get.find<HomeController>();

  int get roleId => homeC.user.value?.roleId ?? 0;

  // index menu yang boleh ditampilkan
  final visibleIndexes = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initMenu();
  }

  void _initMenu() {
    final allIndexes = List.generate(10, (i) => i);

    if (roleId != 1 && roleId != 3) {
      allIndexes.remove(8);
    }

    visibleIndexes.value = allIndexes;
  }
}
