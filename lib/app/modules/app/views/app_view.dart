import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrm/app/modules/absence/views/absence_view.dart';
import 'package:qrm/app/modules/app/views/navigator.dart';
import 'package:qrm/app/modules/home/views/home_view.dart';
import 'package:qrm/app/modules/product/views/product_view.dart';
import 'package:qrm/app/modules/settings/views/settings_view.dart';
import '../controllers/app_controller.dart';

class AppView extends GetView<AppController> {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: controller.navIndex.value,
          children: [
            HomeView(),
            AbsenceView(),
            ProductView(),
            SettingsView(),
          ],
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: NavbarWidget(
            onTap: (index) {
              controller.onNavigate(index);
            },
          ),
        ),
      );
    });
  }
}
