import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/assistive_controller.dart';
import 'package:qrm_dev/app/modules/home/views/widget%20home%20view/widget%20home/widget%20animasi%20appbar/kalkulator_view.dart';

class AssistiveTouchWidget extends StatelessWidget {
  AssistiveTouchWidget({super.key});
  final controller = Get.find<AssistiveTouchController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Positioned(
        left: controller.position.value.dx,
        top: controller.position.value.dy,
        child: GestureDetector(
          onPanStart: (_) => controller.resetIdle(context),
          onPanUpdate: (d) => controller.updatePosition(d, context),
          onTap: () => controller.toggleMenu(context),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (controller.isOpen.value) _menu(),
              _floatingButton(),
            ],
          ),
        ),
      );
    });
  }

  Widget _floatingButton() {
    return Obx(() {
      return AnimatedScale(
        scale: controller.isIdle.value ? 0.75 : 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: AnimatedOpacity(
          opacity: controller.isIdle.value ? 0.6 : 1,
          duration: const Duration(milliseconds: 300),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(153),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24),
            ),
            child: const Icon(
              Icons.circle,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      );
    });
  }

  Widget _menu() {
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            width: 220,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(50),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: Colors.white24),
            ),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _item(Hi.calculator01, 'Kalkulator', () async {
                  final c = Get.find<AssistiveTouchController>();
                  c.closeMenu();
                  c.hide();
                  await Get.dialog(
                    const KalkulatorDialog(),
                    barrierDismissible: true,
                  );
                  c.showAssistive();
                }),
                _item(Icons.notifications, 'Notifications', () {}),
                _item(Icons.phone_android, 'Device', () {}),
                _item(Icons.gesture, 'Gestures', () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
