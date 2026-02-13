import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20rbp%20rb/validasi_rbp_rb_sudah_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20rbp%20rb/widget%20detail%20rbp%20rb/val_rbp_akomodasi_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20rbp%20rb/widget%20detail%20rbp%20rb/val_rbp_alat_tambahan_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20rbp%20rb/widget%20detail%20rbp%20rb/val_rbp_alat_utama_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20rbp%20rb/widget%20detail%20rbp%20rb/val_rbp_hasil_perhitungan_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20rbp%20rb/widget%20detail%20rbp%20rb/val_rbp_informasi_umum_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20rbp%20rb/widget%20detail%20rbp%20rb/val_rbp_material_tambahan_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20rbp%20rb/widget%20detail%20rbp%20rb/val_rbp_material_utama_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20rbp%20rb/widget%20detail%20rbp%20rb/val_rbp_upah_tenaga_kerja_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class ValidasiRbpRbDetailView extends GetView<ValidasiRbpRbSudahController> {
  final String? noHide;
  const ValidasiRbpRbDetailView({super.key, this.noHide});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ValidasiRbpRbSudahController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (noHide != null) {
        controller.getDetailByNoHide(noHide!);
      }
    });
    return Scaffold(
      appBar: CustomAppbar(title: 'RBP RB').appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Obx(() {
              int active = controller.tab.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: LzTabView(
                        tabs: const [
                          'Informasi Umum',
                          'Material Utama',
                          'Material Tambahan',
                          'Upah Tenaga Kerja',
                          'Alat Utama',
                          'Alat Tambahan',
                          'Akomodasi',
                          'Hasil Perhitungan'
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
                    return ValRbpInformasiUmumView(noHide: noHide);
                  case 1:
                    return ValRbpMaterialUtamaView(noHide: noHide);
                  case 2:
                    return ValRbpMaterialTambahanView(noHide: noHide);
                  case 3:
                    return ValRbpUpahTenagaKerjaView(noHide: noHide);
                  case 4:
                    return ValRbpAlatUtamaView(noHide: noHide);
                  case 5:
                    return ValRbpAlatTambahanView(noHide: noHide);
                  case 6:
                    return ValRbpAkomodasiView(noHide: noHide);
                  case 7:
                    return ValRbpHasilPerhitunganView(noHide: noHide);
                  default:
                    return SizedBox();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

final tabs = [];
