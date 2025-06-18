import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/capaian_kinerja/controllers/capaian_kinerja_controller.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/arsiv/arsip_dokumen/arsip_dokumen_hrd_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/arsiv/arsip_karyawan/arsip_karyawan_view.dart';
import 'package:qrm/app/modules/home/views/menus/menus_regional/hrd/menu_HRD/arsiv/arsip_lamaran/arsip_lamaran_view.dart';

class ArsipHrdView extends StatelessWidget {
  final CapaianKinerjaController controller =
      Get.put(CapaianKinerjaController());

  ArsipHrdView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Arsip Karyawan',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: ['4CA1AF'.hex, '808080'.hex],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04, vertical: 50),
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
            SizedBox(height: 20),
            Obx(() {
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
          ],
        ),
      ),
    );
  }
}
