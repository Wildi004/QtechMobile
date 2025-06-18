import 'package:qrm/app/data/models/rab_validasi/rab_validasi.dart';

extension RabValidasiExt on RabValidasi {
  DateTime? get periodeDate {
    if (periode == null) return null;
    return DateTime.tryParse(periode!);
  }

  String get bulanTahunLabel {
    if (periodeDate == null) return 'Tidak diketahui';
    return '${_namaBulan(periodeDate!.month)} ${periodeDate!.year}';
  }

  String _namaBulan(int bulan) {
    const namaBulan = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return namaBulan[bulan];
  }
}
