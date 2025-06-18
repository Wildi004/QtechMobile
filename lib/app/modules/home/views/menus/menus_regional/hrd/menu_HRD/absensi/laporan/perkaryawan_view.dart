import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_absen_controller/laporan_absensi/laporan_absensi_controller.dart';

class PerkaryawanView extends StatelessWidget {
  const PerkaryawanView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LaporanAbsensiController());
    final forms = controller.forms;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        LzForm.select(
            label: 'Regional Karyawan',
            hint: 'Pilih regional',
            model: forms.key('regional'),
            onTap: () async {
              await controller.getRegional();
            },
            onChange: (_) {
              forms.set('employee', '');
            }),
        LzForm.select(
          label: 'Nama Karyawan',
          hint: 'Pilih karyawan',
          model: forms.key('employee'),
          onTap: () async {
            await controller.getEmployee();
          },
        ),
        LzForm.radio(
            label: 'Pilih Periode',
            options: ['Bulan/Tahun', 'Tanggal'],
            model: forms.key('periode')),
        LzForm.input(
            label: 'Pilih Periode',
            hint: 'Pilih periode',
            model: forms.key('date'),
            onTap: () {
              final periode = forms.get('periode');

              if (periode == 'Bulan/Tahun') {
                LzPicker.date(context, format: 'm/y', minDate: DateTime(2018),
                    onSelect: (value) {
                  forms.set('date', value.format('yyyy-MM'));
                  forms.set('bulan', value.format('MM'));
                  forms.set('tahun', value.format('yyyy'));
                });
              } else if (periode == 'Tanggal') {
                LzPicker.date(context, format: 'd/m/y', minDate: DateTime(2018),
                    onSelect: (value) {
                  forms.set('date', value.format('yyyy-MM-dd'));
                });
              } else {
                Toast.show('Silakan pilih periode terlebih dahulu');
              }
            }),
        LzButton(
          text: 'Cetak Absensi',
          onTap: () {
            controller.onSubmit();
          },
        ).margin(all: 20),
      ],
    );
  }
}
