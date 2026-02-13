import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/arsip_dir_bsd.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Arsip%20Dir%20Bsd/arsip_bsd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/arsip%20bsd/arsip%20surat/arsip_surat_keluar_bsd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/arsip%20bsd/arsip_bsd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/arsip%20bsd/arsip%20surat/arsp_surat_masuk_bsd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/arsip%20bsd/create_arsip_bsd_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class TabArsipBsdView extends GetView<ArsipBsdController> {
  const TabArsipBsdView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ArsipBsdController());
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Arsip BSD',
        actions: [
          IconButton(
              onPressed: () {
                Get.dialog(CreateArsipBsdView()).then((data) {
                  if (data != null) {
                    controller.insertData(ArsipDirBsd.fromJson(data));
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
                  return ArsipBsdView();
                case 1:
                  return ArspSuratMasukBsdView();
                case 2:
                  return ArsipSuratKeluarBsdView();

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
