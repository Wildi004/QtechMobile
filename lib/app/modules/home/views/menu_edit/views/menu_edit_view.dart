import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/views/menu_edit/controllers/menu_edit_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menu_edit/views/widget%20edit%20view/other_menu_favorite_view.dart';
import 'package:qrm_dev/app/modules/home/views/widget%20home%20view/widget%20home/menus_favorite_home_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';

class MenuEditView extends GetView<MenuEditController> {
  const MenuEditView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() => PopScope(
          canPop: !controller.isEditing.value, // sekarang reactive
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop && controller.isEditing.value) {
              Get.defaultDialog(
                title: 'Selesaikan Edit',
                titleStyle: TextStyle(fontWeight: Fw.bold),
                middleText: 'Selesaikan edit & simpan dulu.',
              );
            }
          },
          child: Scaffold(
            appBar: CustomAppbarRed(
              title: 'Menu Favorit',
              actions: [
                Obx(() => IconButton(
                      icon: Icon(
                          controller.isEditing.value ? Hi.tick03 : Hi.edit01),
                      onPressed: () {
                        controller.toggleEditing();
                      },
                    )),
              ],
            ).appBar,
            body: LzListView(
              children: [
                Center(
                  child: Text(
                    'Pilih 4 menu favorit anda yang akan tampil pada halaman dashboard utama',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: Fw.bold),
                  ),
                ),
                20.height,
                MenusFavoriteHomeView(),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Container(
                        height: 3,
                        width: MediaQuery.of(context).size.width * 0.74,
                        decoration: CustomDecoration.main2()),
                  ),
                ),
                SizedBox(height: 20),
                OtherMenuFavoriteView(),
              ],
            ),
          ),
        ));
  }
}
