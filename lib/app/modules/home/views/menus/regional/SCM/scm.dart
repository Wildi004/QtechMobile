import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/scm/scm_menu.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/operasi_scm_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

import '../../../../controllers/SCM/scm_controller.dart';

class Scm extends GetView<ScmController> {
  const Scm({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ScmController());
    return Scaffold(
      appBar: CustomAppbar(title: 'Menu SCM').appBar,
      body: Obx(() {
        return LzListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                spacing: MediaQuery.of(context).size.width * 0.06,
                runSpacing: 20,
                children: List.generate(controller.menus.length, (i) {
                  final menu = controller.menus[i];
                  final itemWidth =
                      (MediaQuery.of(context).size.width - 20) / 6;

                  return SizedBox(
                    width: itemWidth,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (menu.label == 'Direktur SCM') {
                              // Get.toNamed('/dir-scm');
                            } else if (menu.label == 'Data Kontrak') {
                              // Get.toNamed('/kontrak');
                            } else if (menu.label == 'Operasi SCM') {
                              Get.to(() => OperasiScmView());
                            }
                          },
                          child: _buildIcon(menu),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          menu.label,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      }),
    );
  }
}

Widget _buildIcon(ScmMenu menu) {
  if (menu.icon.endsWith('.svg')) {
    return SvgPicture.asset(
      menu.icon,
      width: 40,
      height: 40,
      fit: BoxFit.contain,
    );
  }

  return Image.asset(
    menu.icon,
    width: MediaQuery.of(Get.context!).size.width * 0.13,
  );
}
