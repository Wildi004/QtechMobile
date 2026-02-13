import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_arsip_controller/arsip_karyawan_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/arsiv/arsip_dokumen/arsip_dokumen_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/arsiv/arsip_karyawan/arsip_karyawan_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/arsiv/arsip_lamaran/arsip_lamaran_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class ArsipHrdView extends StatelessWidget {
  final ArsipKaryawanController controller = Get.put(ArsipKaryawanController());

  ArsipHrdView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar(title: 'Arsip HRD').appBar,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Obx(() {
              int active = controller.tabIndex.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: LzTabView(
                      tabs: const [
                        'Arsip Karyawan',
                        'Arsip Lamaran Kerja',
                        'Arsip Dokumen',
                      ],
                      onTap: (key, i) {
                        controller.tabIndex.value = i;
                      },
                      builder: (label, i) {
                        bool isActive = active == i;
                        return Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: isActive
                                ? Color.fromARGB(255, 173, 155, 38)
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
              );
            }),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (controller.tabIndex.value == 0) {
                  return ArsipKaryawanView();
                }
                if (controller.tabIndex.value == 1) {
                  return ArsipLamaranView();
                }
                if (controller.tabIndex.value == 2) {
                  return ArsipDokumenHrdView();
                }
                return SizedBox();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
