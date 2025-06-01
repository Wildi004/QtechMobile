import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_absen_controller/laporan_absensi/laporan_absensi_controller.dart';

class PerkaryawanView extends StatelessWidget {
  const PerkaryawanView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LaporanAbsensiController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LzForm.select(
          label: 'Regional Karyawan',
          model: controller.forms.key('city'),
          onTap: () async {
            final data = await controller.getreg().overlay();
            controller.forms.set('city').options(data.labelValue('name', 'id'));
          },
        ),
        LzForm.select(
          label: 'Nama Karyawan',
          model: controller.forms.key('province'),
          onTap: () async {
            final data = await controller.getkar().overlay();
            controller.forms
                .set('province')
                .options(data.labelValue('name', 'id'));
          },
        ),
        LzForm.input(hint: 'Periode', readOnly: true),
        const SizedBox(height: 6),
        Text('Download PDF', style: Gfont.fs14),
        const SizedBox(height: 6),
        LzForm.input(
            prefixIcon: Hi.pdf01,
            hint: 'File Absensi Setelah Filter',
            readOnly: true),
      ],
    );
  }
}
