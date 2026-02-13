import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_absen_controller/laporan_absensi/laporan_absensi_controller.dart';

class PerkaryawanView extends StatelessWidget {
  const PerkaryawanView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LaporanAbsensiController());
    final forms = controller.forms;

    return SafeArea(
      child: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LzForm.select(
              label: 'Regional Karyawan',
              style: OptionPickerStyle(withSearch: true),
              hint: 'Pilih regional',
              model: forms.key('regional'),
              onTap: () async {
                // Ambil data static dari regs
                final data = await controller.getReg();
                final options = data
                    .map((e) => {
                          'label': e['name'],
                          'value': e['name'], // value sama dengan name
                        })
                    .toList();

                forms.set('regional').options(options);
              },
              onChange: (_) {
                // Reset employee jika regional berubah
                forms.set('employee', '');
              },
            ),
            LzForm.select(
              label: 'Nama Karyawan',
              style: OptionPickerStyle(withSearch: true),
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
                    LzPicker.date(context,
                        format: 'm/y',
                        minDate: DateTime(2018), onSelect: (value) {
                      forms.set('date', value.format('yyyy-MM'));
                      forms.set('bulan', value.format('MM'));
                      forms.set('tahun', value.format('yyyy'));
                    });
                  } else if (periode == 'Tanggal') {
                    LzPicker.date(context,
                        format: 'd/m/y',
                        minDate: DateTime(2018), onSelect: (value) {
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
        ),
      ),
    );
  }
}
