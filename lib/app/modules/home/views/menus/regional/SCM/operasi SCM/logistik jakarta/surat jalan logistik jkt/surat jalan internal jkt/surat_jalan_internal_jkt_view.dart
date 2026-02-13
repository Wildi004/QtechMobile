import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/surat_jalan_internal/surat_jalan_internal.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Surat%20Jalan%20Logistik%20Jkt/surat%20jalan%20internal%20jkt/surat_jalan_internal_jkt_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/surat%20jalan%20logistik%20jkt/surat%20jalan%20internal%20jkt/surat_jalan_internal_jkt_belum_val_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik%20jakarta/surat%20jalan%20logistik%20jkt/surat%20jalan%20internal%20jkt/surat_jalan_internal_jkt_sudah_val_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/surat%20jalan%20logistik/surat%20jalan%20internal/create_surat_jalan_internal_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class SuratJalanInternalJktView
    extends GetView<SuratJalanInternalJktController> {
  const SuratJalanInternalJktView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SuratJalanInternalJktController());
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Surat Jalan Internal',
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => CreateSuratJalanInternalView())?.then((data) {
                if (data != null) {
                  controller.insertData(SuratJalanInternal.fromJson(data));
                }
              });
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
                        'Belum Validasi',
                        'Sudah Validasi',
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
                  return SuratJalanInternalJktBelumValView();
                case 1:
                  return SuratJalanInternalJktSudahValView();
                case 2:
                default:
                  return SizedBox.shrink();
              }
            }),
          ),
        ],
      ),
    );
  }
}
