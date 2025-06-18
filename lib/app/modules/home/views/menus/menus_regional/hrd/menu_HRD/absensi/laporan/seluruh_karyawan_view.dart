import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_absen_controller/laporan_absensi/laporan_absensi_controller.dart';

class FilterAbsensiView extends StatelessWidget {
  const FilterAbsensiView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LaporanAbsensiController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LzForm.select(
          label: 'Filter Berdasarkan',
          hint: 'Pilih Filter',
          model: controller.forms.key('city'),
          onTap: () async {},
        ),
        const SizedBox(height: 6),
        const SizedBox(height: 6),
        LzForm.input(
            prefixIcon: Hi.pdf01,
            hint: 'File Absensi Setelah Filter',
            readOnly: true),
      ],
    );
  }
}
