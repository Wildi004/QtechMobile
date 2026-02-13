// ignore_for_file: must_be_immutable
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/views/menu_edit/controllers/menu_edit_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menu_edit/views/menu_edit_view.dart';
import 'package:qrm_dev/app/modules/home/views/widget%20home%20view/widget%20home/appbar_home_view.dart';
import 'package:qrm_dev/app/modules/home/views/widget%20home%20view/widget%20home/event_home_view.dart';
import 'package:qrm_dev/app/modules/home/views/widget%20home%20view/widget%20home/main_menu_favorite.dart';
import 'package:qrm_dev/app/modules/home/views/widget%20home%20view/widget%20home/regional_menus_home_view.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import '../controllers/home_controller.dart';
import 'widget home view/widget home/card_name_home_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    final menuEditController = Get.find<MenuEditController>();
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    return Scaffold(
      body: Stack(
        children: [
          LzListView(
            shrinkWrap: true,
            onRefresh: () => controller.onPageInit(),
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: size.width * 0.088,
            ),
            children: [
              AppbarHomeView(
                controller: controller,
                size: size,
              ),
              SizedBox(height: 10),
              CardName(),
              SizedBox(height: 20),
              EventHomeView(),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Menu Favorite",
                    style: GoogleFonts.robotoSlab().copyWith(
                      fontWeight: Fw.bold,
                      fontSize: 18,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => MenuEditView());
                    },
                    child: Text("Edit",
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              MainMenuFavorite(
                menuEditController: menuEditController,
                size: size,
              ),
              SizedBox(height: 10),
              RegionalMenusHomeView(screenWidth: screenWidth),
            ],
          ),
          Obx(() {
            if (!controller.isLoading.value) return SizedBox();
            return Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 3,
                  sigmaY: 3,
                ),
                child: Container(
                  color: Colors.white.withValues(alpha: 0.40),
                  child: Center(
                    child: CustomLoading(),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
