import 'package:get/get.dart';

class AppController extends GetxController {
  RxBool isLogged = false.obs;
  RxBool showSplash = true.obs;
  RxInt navIndex = 0.obs;

  List<int> visited = [0];

  void onNavigate(int index) {
    navIndex.value = index;

    visited.addIf(!visited.contains(index), index);
  }
}
