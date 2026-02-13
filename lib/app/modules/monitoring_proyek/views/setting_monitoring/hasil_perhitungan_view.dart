import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/monitoring_proyek/controllers/monitor_controller.dart';

class HasilPerhitunganView extends GetView<MonitorController> {
  const HasilPerhitunganView({super.key});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          LzForm.input(
            maxLines: 10,
            enabled: false,
            label: 'Total Beban Proyek',
            model: forms.key('jumlah_total'),
          ),
          LzForm.input(
            maxLines: 10,
            enabled: false,
            label: 'Nilai Penawaran/Nilai Kontrak',
            model: forms.key('nilai_kontrak'),
          ),
          LzForm.input(
            maxLines: 10,
            enabled: false,
            label: 'Nilai Pendapatan',
            model: forms.key('dpp_pendapatan'),
          ),
          LzForm.input(
            maxLines: 10,
            enabled: false,
            label: 'Management Fee Kantor',
            model: forms.key('man_fee_kantor'),
          ),
          LzForm.input(
            maxLines: 10,
            enabled: false,
            label: 'Komitmen Fee Kantor',
            model: forms.key('kom_fee_kantor'),
          ),
          LzForm.input(
            maxLines: 10,
            enabled: false,
            label: 'Nilai PPH',
            model: forms.key('nilai_pph'),
          ),
          LzForm.input(
            maxLines: 10,
            enabled: false,
            label: 'Nilai PPN',
            model: forms.key('nilai_ppn'),
          ),
          LzForm.input(
            maxLines: 10,
            enabled: false,
            label: 'Nilai SCF',
            model: forms.key('nilai_scf'),
          ),
        ],
      ),
    );
  }
}
