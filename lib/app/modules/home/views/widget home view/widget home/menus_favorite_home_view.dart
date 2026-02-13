import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/views/menu_edit/controllers/menu_edit_controller.dart';
import 'package:qrm_dev/app/widgets/custom_blink_icon.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_sacala_view.dart';

class MenusFavoriteHomeView extends GetView<MenuEditController> {
  const MenusFavoriteHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: CustomDecoration.main2(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const int itemPerRow = 4;
          const double spacing = 10;
          final totalSpacing = spacing * (itemPerRow - 1);
          final itemWidth = (constraints.maxWidth - totalSpacing) / itemPerRow;
          final iconSize = itemWidth * 0.7;

          return Obx(() {
            final menus =
                controller.favoriteMenus.where((item) => item != null).toList();
            return Wrap(
              spacing: spacing,
              runSpacing: 20,
              children: menus.map((item) {
                return SizedBox(
                  width: itemWidth,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomScaleView(
                        child: GestureDetector(
                          onTap: () {
                            if (controller.isEditing.value) {
                              controller.removeFromFavoriteByItem(item);
                            } else {
                              controller.navigateTo(item['route']);
                            }
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              item!['icon'] is String
                                  ? Image.asset(
                                      item['icon'],
                                      width: iconSize,
                                      height: iconSize,
                                    )
                                  : Icon(item['icon'], size: iconSize),
                              const SizedBox(height: 6),
                              SizedBox(
                                width: itemWidth,
                                child: Text(
                                  item['label'],
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (controller.isEditing.value)
                        Positioned(
                          top: -6,
                          right: -6,
                          child: GestureDetector(
                            onTap: () =>
                                controller.removeFromFavoriteByItem(item),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(4),
                              child: BlinkingIcon(
                                icon: const Icon(
                                  Hi.remove01,
                                  size: 10,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            );
          });
        },
      ),
    );
  }
}
