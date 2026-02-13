import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/proyek_item/proyek_item.dart';
import 'package:qrm_dev/app/modules/monitoring_proyek/controllers/monitor_controller.dart';
import 'package:qrm_dev/app/modules/monitoring_proyek/views/setting_monitoring/Pekerjaan_monitoring_view.dart';

class InformasiUmum extends GetView<MonitorController> {
  final ProyekItems? data;
  const InformasiUmum({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    return LzListView(
      gap: 20,
      children: [
        LzForm.input(
            enabled: false,
            label: 'Kode Proyek',
            model: forms.key('kode_proyek')),
        LzForm.input(
            maxLines: 10,
            enabled: false,
            label: 'Judul Pekerjaan',
            model: forms.key('judul_kontrak')),
        LzForm.input(
            enabled: false,
            label: 'Nilai Kontrak',
            model: forms.key('nilai_kontrak')),
        LzForm.input(
            enabled: false,
            label: 'No Kontrak',
            model: forms.key('no_kontrak')),
        Row(
          children: [
            Expanded(
              child: LzForm.input(
                enabled: false,
                label: 'Area Proyek',
                model: forms.key('area_proyek'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: LzForm.input(
                enabled: false,
                label: 'Tanggal Kontrak',
                model: forms.key('tgl_kontrak'),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: LzForm.input(
                enabled: false,
                label: 'Durasi kontrak',
                model: forms.key('durasi_kontrak'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: LzForm.input(
                enabled: false,
                label: 'Durasi Proyek',
                model: forms.key('durasi_proyek'),
              ),
            ),
          ],
        ),
        LzForm.input(
          maxLines: 10,
          enabled: false,
          label: 'Lokasi Proyek',
          model: forms.key('lokasi_proyek'),
        ),
        LzForm.input(
          maxLines: 10,
          enabled: false,
          label: 'Perusahaan Pemberi Kerja Area Proyek',
          model: forms.key('vendor'),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 140),
          child: LzButton(
            text: 'Pekerjaan',
            onTap: () {
              Get.to(() => PekerjaanMonitoringView(
                    items: data?.dataProyekItem ?? [],
                  ));
            },
          ),
        ),
      ],
    );
  }
}
