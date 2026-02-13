import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/views/menu_edit/controllers/menu_edit_controller.dart';
import 'package:qrm_dev/app/widgets/custom_blink_icon.dart';
import 'package:qrm_dev/app/widgets/custom_sacala_view.dart';

class OtherMenuFavoriteView extends GetView<MenuEditController> {
  const OtherMenuFavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Obx(() {
      return Wrap(
        alignment: WrapAlignment.start,
        spacing: 10,
        runSpacing: 25,
        children: List.generate(controller.otherMenus.length, (i) {
          final item = controller.otherMenus[i];

          return SizedBox(
            width: (size.width - 70) / 4,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  child: CustomScaleView(
                    key: ValueKey(controller.isEditing.value),
                    child: GestureDetector(
                      onTap: () {
                        if (controller.isEditing.value) {
                          controller.addToFavorite(i);
                        } else {
                          controller.navigateTo(item['route']);
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: item['icon'] is String
                                ? Image.asset(
                                    item['icon'],
                                    width: 45,
                                    height: 45,
                                  )
                                : Icon(
                                    item['icon'],
                                    size: 45,
                                  ),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 50,
                            child: Text(
                              item['label'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (controller.isEditing.value)
                  Positioned(
                    top: -5,
                    right: -5,
                    child: GestureDetector(
                      onTap: () {
                        controller.addToFavorite(i);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 130, 14, 6),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(2),
                        child: BlinkingIcon(
                          icon: const Icon(
                            Hi.add01,
                            size: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }),
      );
    });
  }
}
