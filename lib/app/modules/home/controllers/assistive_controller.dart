import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrm_dev/app/routes/app_pages.dart';

class AssistiveTouchController extends GetxController {
  Rx<Offset> position = const Offset(20, 150).obs;
  RxBool isOpen = false.obs;
  RxBool isIdle = false.obs;
  final show = true.obs;

  void updateByRoute(String route) {
    const hiddenRoutes = [Routes.LOGIN];
    show.value = !hiddenRoutes.contains(route);
  }

  void hide() => show.value = false;
  void showAssistive() => show.value = true;
  Timer? _idleTimer;
  void resetIdle(BuildContext context) {
    _idleTimer?.cancel();
    isIdle.value = false;
    _idleTimer = Timer(const Duration(seconds: 2), () {
      closeMenu();
      isIdle.value = true;
      snapToEdge(context);
    });
  }

  void updatePosition(DragUpdateDetails details, BuildContext context) {
    position.value += details.delta;
    resetIdle(context);
  }

  void toggleMenu(BuildContext context) {
    isOpen.toggle();
    resetIdle(context);
  }

  void closeMenu() {
    isOpen.value = false;
  }

  void snapToEdge(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final buttonSize = 50.0;
    final isLeft = position.value.dx < size.width / 2;
    position.value = Offset(
      isLeft ? -buttonSize / 2 : size.width - buttonSize / 2,
      position.value.dy.clamp(
        100,
        size.height - 120,
      ),
    );
  }

  @override
  void onClose() {
    _idleTimer?.cancel();
    super.onClose();
  }
}
