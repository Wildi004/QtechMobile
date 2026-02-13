import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qrm_dev/app/modules/home/views/menu_edit/controllers/menu_edit_controller.dart';
import 'package:qrm_dev/app/widgets/custom_sacala_view.dart';

class MainMenuFavorite extends StatelessWidget {
  final MenuEditController menuEditController;
  final Size size;

  const MainMenuFavorite({
    super.key,
    required this.menuEditController,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            menuEditController.favoriteMenus.length,
            (i) {
              final item = menuEditController.favoriteMenus[i];

              final iconSize = 45.0;

              if (item == null) return const SizedBox();

              return Padding(
                padding: EdgeInsets.all(8),
                child: CustomScaleView(
                  child: GestureDetector(
                    onTap: () => menuEditController.navigateTo(item['route']),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        (item['icon'] is String)
                            ? Image.asset(
                                item['icon'],
                                width: iconSize,
                                height: iconSize,
                                fit: BoxFit.contain,
                              )
                            : Icon(
                                item['icon'],
                                color: Colors.white,
                                size: iconSize,
                              ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 68.0,
                          child: Text(
                            item['label'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.robotoCondensed(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
