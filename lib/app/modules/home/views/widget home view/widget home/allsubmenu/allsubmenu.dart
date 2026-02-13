import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/role_akses/sub_menu.dart';
import 'package:qrm_dev/app/modules/home/views/widget%20home%20view/widget%20home/allsubmenu/menu%20management/menu_manag_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_sacala_view.dart';

class AllSubMenuView extends StatelessWidget {
  final List<SubMenu> menus;
  const AllSubMenuView(this.menus, {super.key});

  @override
  Widget build(BuildContext context) {
    final double itemWidth = (MediaQuery.of(context).size.width - (20 * 1)) / 6;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Semua Menu Regional',
      ).appBar,
      body: LzListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Wrap(
              spacing: MediaQuery.of(context).size.width * 0.05,
              runSpacing: 15,
              children: List.generate(menus.length, (i) {
                final e = menus[i];

                return SizedBox(
                  width: itemWidth,
                  child: Column(
                    children: [
                      CustomScaleView(
                        child: GestureDetector(
                          onTap: () {
                            switch (e.name) {
                              case 'Dashboard Umum':
                                Get.snackbar(
                                    'Info', 'Sedang Tahap Pengembangan');
                                break;

                              default:
                                Get.snackbar(
                                    'Info', '${e.name} belum tersedia');
                            }
                          },
                          child: buildMenuIcon(
                            e.name,
                            size: MediaQuery.of(context).size.width * 0.10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        e.name ?? '-',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
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
      ),
    );
  }
}
