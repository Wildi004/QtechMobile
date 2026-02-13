import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/arsip_it.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Arsip%20IT/arsip_it_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/arsip%20it/arsip%20surat/arsip_surat_keluar_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/arsip%20it/arsip%20surat/arsp_surat_masuk_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/arsip%20it/arsip_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/arsip%20it/create_arsip_it_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class TabArsipItView extends GetView<ArsipItController> {
  const TabArsipItView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ArsipItController());
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Arsip IT',
        actions: [
          IconButton(
              onPressed: () {
                Get.dialog(CreateArsipItView()).then((data) {
                  if (data != null) {
                    controller.insertData(ArsipIt.fromJson(data));
                  }
                });
              },
              icon: Icon(Hi.add01)),
        ],
      ).appBar,
      body: Column(
        children: [
          Obx(() {
            int active = controller.tab.value;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: LzTabView(
                      tabs: const [
                        'Arsip',
                        'Arsip Surat masuk',
                        'Arsip Surat Keluar',
                      ],
                      onTap: (key, i) {
                        controller.tab.value = i;
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
                ),
              ],
            );
          }),
          Expanded(
            child: Obx(() {
              switch (controller.tab.value) {
                case 0:
                  return ArsipItView();
                case 1:
                  return ArspSuratMasukItView();
                case 2:
                  return ArsipSuratKeluarItView();

                default:
                  return SizedBox();
              }
            }),
          ),
        ],
      ),
    );
  }
}
