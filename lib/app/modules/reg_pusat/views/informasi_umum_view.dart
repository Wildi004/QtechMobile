import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/monitoring_proyek/controllers/monitoring_proyek_controller.dart';

class InformasiUmumView extends GetView<MonitoringProyekController> {
  const InformasiUmumView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MonitoringProyekController());

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          LzForm.input(
            label: 'Kode Proyek',
            hint: 'QRM 401/K-P',
            enabled: false,
          ),
          LzForm.input(label: 'Judul Pekerjaan', enabled: false, maxLines: 5),
          LzForm.input(
            label: 'Nilai Kontrak',
            enabled: false,
          ),
          LzForm.input(
            label: 'No. Kontrak',
            enabled: false,
          ),
          Row(
            children: [
              Expanded(
                  child: LzForm.input(
                label: 'Alat Proyek',
                hint: '',
                enabled: false,
              )),
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: LzForm.input(
                label: 'Tanggal Kontrak',
                hint: '',
                enabled: false,
              )),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: LzForm.input(
                label: 'Durasi Kontrak',
                hint: '',
                enabled: false,
              )),
              SizedBox(
                width: 15,
              ),
              Expanded(
                  child: LzForm.input(
                label: 'Durasi Proyek',
                hint: '',
                enabled: false,
              )),
            ],
          )..gap(10),
          LzForm.input(
            label: 'Lokasi Proyek',
            hint: '',
            enabled: false,
          ),
          LzForm.input(
            label: 'Perusahaan Pemberi Kerja Area Proyek',
            hint: '',
            enabled: false,
          ),
        ],
      ),
    );
  }
}
