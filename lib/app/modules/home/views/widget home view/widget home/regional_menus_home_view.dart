import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/role_akses/sub_menu.dart';
import 'package:qrm_dev/app/modules/company_profile/views/company_profile_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/bsd.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/legal_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/widget%20home%20view/widget%20home/allsubmenu/allsubmenu.dart';
import 'package:qrm_dev/app/modules/home/views/widget%20home%20view/widget%20home/allsubmenu/menu%20management/menu_manag_view.dart';
import 'package:qrm_dev/app/modules/role_akses_1/views/role_akses_1_view.dart';
import 'package:qrm_dev/app/modules/settings/views/menus%20setting/data_diri/views/form_profile_view.dart';

import '../../../../../widgets/custom_decoration.dart';
import '../../../controllers/home_controller.dart';
import '../../menus/regional/SCM/scm.dart';

class RegionalMenusHomeView extends GetView<HomeController> {
  final double screenWidth;
  const RegionalMenusHomeView({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: Caa.start,
          children: [
            Text(
              "Menu Regional",
              style: GoogleFonts.robotoSlab().copyWith(
                fontWeight: Fw.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Obx(() {
          int active = controller.tabIndex.value;
          final menus = controller.regionalMenus;
          return LayoutBuilder(
            builder: (context, constraints) {
              double paddingV = 2.0;
              double paddingH = 8.0;
              double marginL = 8.0;
              double borderRadius = 50;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: LzTabView(
                      tabs: menus.map((e) => e.name.toString()).toList(),
                      onTap: (key, i) {
                        controller.tabIndex.value = i;
                      },
                      builder: (label, i) {
                        bool isActive = active == i;
                        return Container(
                          padding: EdgeInsets.symmetric(
                              vertical: paddingV, horizontal: paddingH),
                          decoration: isActive
                              ? CustomDecoration.main2(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  border: Border.all(color: Colors.black),
                                )
                              : BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  border: Border.all(color: Colors.black),
                                ),
                          margin: EdgeInsets.only(left: i == 0 ? 0 : marginL),
                          child: Text(
                            label,
                            style: TextStyle(
                              color: isActive ? Colors.white : Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        }),
        SizedBox(height: 12.0),
        Obx(() {
          int tab = controller.tabIndex.value;
          final regionalMenus = controller.regionalMenus;

          final filtered = (regionalMenus.isEmpty
                  ? <SubMenu>[]
                  : (regionalMenus[tab].subMenu ?? []))
              .where((e) => e.isActive == 1);

          final menus = [...filtered.take(filtered.length > 4 ? 3 : 4)];

          if (filtered.length > 4) {
            menus.add(SubMenu(name: 'More'));
          }

          return Intrinsic(children: menus.generate((e, i) {
            return Touch(
              onTap: () {
                if (e.name == 'More') {
                  Get.to(() => AllSubMenuView(filtered.toList()));
                } else {
                  switch (e.name) {
                    case 'Menu BSD':
                      Get.to(() => Bsd());
                      break;

                    case 'HRD':
                      Get.to(() => Bsd());
                      break;

                    case 'Dashboard Logistik':
                      Get.to(() => LogistikView());
                      break;

                    case 'Dashboard HRD':
                      Get.to(() => HrdView());
                      break;
                    case 'Company Profile':
                      Get.to(() => CompanyProfileView());
                      break;
                    case 'My Profile':
                      Get.to(() => FormProfileView());
                      break;

                    case 'Dashboard Legal':
                      Get.to(() => LegalView());
                      break;
                    case 'Menu SCM':
                      Get.to(() => Scm());
                      break;

                    case 'Role Access':
                      Get.to(() => RoleAkses1View());
                      break;
                    default:
                  }
                }
              },
              padding: Ei.sym(v: 10),
              child: Column(
                spacing: 15,
                children: [
                  buildMenuIcon(e.name, size: 35),
                  Text('${e.name}', textAlign: Ta.center, style: Gfont.fs14)
                ],
              ),
            );
          }));
        }),
      ],
    );
  }
}
