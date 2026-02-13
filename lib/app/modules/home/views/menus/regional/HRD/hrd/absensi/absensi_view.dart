import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_absen_controller/absen_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/absensi/building/building_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/absensi/holiday/libur_nasional_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/absensi/laporan/laporan_absensi_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/absensi/shift/shift_hrd_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class AbsensiView extends GetView<AbsenController> {
  const AbsensiView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AbsenController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar(
        title: 'Absensi',
      ).appBar,
      body: Padding(
        padding: const EdgeInsets.all(15),
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
                        'jam',
                        'Lokasi',
                        'Laporan absensi',
                        'Libur nasional',
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
              );
            }),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (controller.tabIndex.value == 0) {
                  return ShiftHrdView();
                } else if (controller.tabIndex.value == 3) {
                  return LiburNasionalView();
                } else if (controller.tabIndex.value == 2) {
                  return LaporanAbsensiView();
                } else if (controller.tabIndex.value == 1) {
                  return BuildingHrdView();
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
