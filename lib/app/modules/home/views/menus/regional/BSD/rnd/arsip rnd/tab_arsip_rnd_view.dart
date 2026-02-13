import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20rnd/arsip_rnd.dart';
import 'package:qrm_dev/app/modules/home/controllers/RND/Arsip%20RND/arsip_rnd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/arsip%20rnd/arsip%20surat/arsip_surat_keluar_rnd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/arsip%20rnd/arsip%20surat/arsp_surat_masuk_rnd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/arsip%20rnd/arsip_rnd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/arsip%20rnd/create_arsip_rnd_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class TabArsipRndView extends GetView<ArsipRndController> {
  const TabArsipRndView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ArsipRndController());
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Arsip IT',
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Get.to(
                () => const CreateArsipRndView(),
              );

              if (result != null) {
                controller.insertData(ArsipRnd.fromJson(result));
              }
            },
            icon: Icon(Hi.add01),
          ),
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
                  return ArsipRndView();
                case 1:
                  return ArspSuratMasukRndView();
                case 2:
                  return ArsipSuratKeluarRndView();

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
