import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class HasilPerhitunganView extends StatelessWidget {
  const HasilPerhitunganView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          LzForm.input(
            label: 'Total Beban Proyek',
            hint: '',
            enabled: false,
          ),
          LzForm.input(
              label: 'Nilai Penawaran/Nilai Kontrak',
              enabled: false,
              maxLines: 5),
          LzForm.input(
            label: 'Nilai Pendapatan',
            enabled: false,
          ),
          LzForm.input(
            label: 'Management Fee Kantor',
            enabled: false,
          ),
          LzForm.input(
            label: 'Komitmen Fee Kantor',
            hint: '',
            enabled: false,
          ),
          LzForm.input(
            label: 'Nilai PPH',
            hint: '',
            enabled: false,
          ),
          LzForm.input(
            label: 'Nilai PPN',
            hint: '',
            enabled: false,
          ),
          LzForm.input(
            label: 'Nilai SCF',
            hint: '',
            enabled: false,
          ),
          LzForm.input(
            label: 'Pendapatan Netto',
            hint: '',
            enabled: false,
          ),
          LzForm.input(
            label: 'Estimasi laba (Netto - Beban Proyek)',
            hint: '',
            enabled: false,
          ),
        ],
      ),
    );
  }
}
