import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_setting_controller/setting_dev_controller/setting_dev_controller.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/setting/cuti_hrd/cuti_hrd_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/setting/departemen_hrd/departemen_hrd_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/setting/regional_hrd/regional_hrd_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/setting/status_kawin_hrd/status_kawin_hrd_view.dart';

class SettingHrdView extends GetView<SettingDevController> {
  const SettingHrdView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingDevController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Setting",
          style: TextStyle(color: Colors.white, fontWeight: Fw.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 6, 91, 122),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // Tombol Buat Notulen

            const SizedBox(height: 20),

            // Tab View
            Obx(() {
              int active = controller.tabIndex.value;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: LzTabView(
                          tabs: const [
                            'Departemen',
                            'Status Kawin',
                            'Regional',
                            'Cuti',
                          ],
                          onTap: (key, i) {
                            controller.tabIndex.value = i;
                          },
                          builder: (label, i) {
                            bool isActive = active == i;
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? const Color.fromARGB(255, 173, 155, 38)
                                    : const Color.fromARGB(255, 243, 238, 238),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.black),
                              ),
                              margin: EdgeInsets.only(left: i == 0 ? 0 : 8),
                              child: Text(
                                label,
                                style: TextStyle(
                                  color: isActive ? Colors.white : Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Tambahan TextField Pencarian
                  // TextField(
                  //   onChanged: controller.updateSearchQuery,
                  //   decoration: InputDecoration(
                  //     hintText: "Cari...",
                  //     prefixIcon: Icon(Icons.search),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     contentPadding: EdgeInsets.symmetric(vertical: 10),
                  //   ),
                  // ),
                ],
              );
            }),

            const SizedBox(height: 10),

            // List Notulen dengan Expanded agar tidak overflow
            Expanded(
              child: Obx(() {
                if (controller.tabIndex.value == 0) {
                  return DepartemenHrdView();
                } else if (controller.tabIndex.value == 1) {
                  return StatusKawinHrdView();
                } else if (controller.tabIndex.value == 3) {
                  return CutiHrdView();
                } else if (controller.tabIndex.value == 2) {
                  return RegionalHrdView();
                }
                return const SizedBox();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
