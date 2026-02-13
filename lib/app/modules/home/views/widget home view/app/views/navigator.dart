import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'dart:ui';

import '../controllers/app_controller.dart';

class NavbarWidget extends GetView<AppController> {
  final Function(int index)? onTap;
  const NavbarWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final labels = ['Home', 'Absen', 'Surat Masuk', 'Settings'];
    return Obx(() {
      int navIndex = controller.navIndex.value;
      return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.width * 0.02,
            left: MediaQuery.of(context).size.width * 0.06,
            right: MediaQuery.of(context).size.width * 0.06,
            top: MediaQuery.of(context).size.width * 0.003,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 35,
                sigmaY: 35,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.width * 0.01,
                  horizontal: MediaQuery.of(context).size.width * 0.02,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                    width: 1,
                  ),
                  boxShadow: [
                    // Shadow bawah (angkat)
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.30),
                      blurRadius: 30,
                      offset: const Offset(0, 18),
                    ),

                    // Shadow halus dekat body
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.10),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ['home', 'absensi', 'user', 'lzimage']
                          .generate((item, i) {
                        final isActive = navIndex == i;
                        return InkWell(
                          onTap: () => onTap?.call(i),
                          onTapDown: (_) => controller.pressedIndex.value = i,
                          onTapUp: (_) => controller.pressedIndex.value = -1,
                          onTapCancel: () => controller.pressedIndex.value = -1,
                          splashColor: Colors.red.withValues(alpha: 0.5),
                          highlightColor: Colors.red.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 1,
                              horizontal: 14,
                            ),
                            child: Column(
                              children: [
                                buildIcon(
                                  i == 0
                                      ? 'home.png'
                                      : i == 1
                                          ? 'absensi.png'
                                          : i == 2
                                              ? 'user.png'
                                              : 'icons setting.png',
                                  isActive,
                                  controller.pressedIndex.value == i,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  labels[i],
                                  style: Gfont.fs12
                                      .fcolor(isActive
                                          ? const Color.fromARGB(
                                              255, 208, 56, 56)
                                          : const Color.fromARGB(255, 0, 0, 0))
                                      .copyWith(fontSize: 10),
                                ),
                                const SizedBox(height: 4),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: 3,
                                  width: isActive ? 26 : 0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2),
                                    boxShadow: isActive
                                        ? [
                                            BoxShadow(
                                              color: Colors.white
                                                  .withValues(alpha: 0.8),
                                              blurRadius: 10,
                                              spreadRadius: 1,
                                            ),
                                          ]
                                        : [],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ),
            ),
          ));
    });
  }
}

Widget buildIcon(
  String asset,
  bool isActive,
  bool isPressed,
) {
  return AnimatedScale(
    scale: isPressed ? 0.92 : 1.0,
    duration: const Duration(milliseconds: 120),
    curve: Curves.easeOut,
    child: AnimatedSlide(
      duration: const Duration(milliseconds: 420),
      curve: Curves.elasticOut, // 🔥 spring iOS
      offset: Offset(0, isActive ? -0.18 : -0.05),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Shadow base
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: isActive ? 0.45 : 0.30,
                  ),
                  blurRadius: isActive ? 16 : 10,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: LzImage(asset, size: 28),
          ),

          // Highlight glossy
          Positioned(
            top: 2,
            child: Container(
              width: 18,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.45),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
