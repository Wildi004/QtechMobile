import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/proyek_item/proyek_item.dart';
import 'package:qrm_dev/app/modules/monitoring_proyek/controllers/monitor_controller.dart';
import 'package:qrm_dev/app/modules/monitoring_proyek/views/setting_monitoring/hasil_perhitungan_view.dart';
import 'package:qrm_dev/app/modules/monitoring_proyek/views/setting_monitoring/informasi_umum.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class SettingMonitoringView extends GetView<MonitorController> {
  final ProyekItems? data;
  const SettingMonitoringView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
    }
    return Scaffold(
      appBar: CustomAppbar(title: 'Monitoring Proyek').appBar,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 239, 239, 239),
                  border: Border.all(
                    color: const Color.fromARGB(255, 57, 57, 57),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  data?.kodeProyek ?? '-',
                  style: GoogleFonts.poppins().copyWith(
                    fontWeight: Fw.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Obx(() {
              int active = controller.tabIndex.value;
              return Align(
                alignment: Alignment.center,
                child: IntrinsicWidth(
                  child: LzTabView(
                    tabs: const [
                      'Informasi Umun',
                      'Hasil Perhitungan',
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
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (controller.tabIndex.value == 0) {
                  return InformasiUmum(data: data);
                } else if (controller.tabIndex.value == 1) {
                  return HasilPerhitunganView();
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
