import 'package:qrm_dev/app/data/models/model%20legal/rab_legal/rab_legal.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/rab_logistik/rab_logistik.dart';
import 'package:qrm_dev/app/data/models/models%20it/rab_it/rab_it.dart';

extension RabValidasiExt on RabIt {
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

extension RabGroupLegal on RabLegal {
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

extension RabGroupLogistik on RabLogistik {
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
