import 'package:qrm_dev/app/data/models/count_notif/count_logistik.dart';
import 'package:qrm_dev/app/data/models/count_notif/count_rab.dart';

import 'pengajuan_departemen.dart';
import 'ptj_departemen.dart';

class CountNotif {
  PengajuanDepartemen? pengajuanDepartemen;
  PtjDepartemen? ptjDepartemen;
  LogistikCount? logistik;
  RabDepartemen? rabDepartemen;

  CountNotif({
    this.pengajuanDepartemen,
    this.ptjDepartemen,
    this.logistik,
    this.rabDepartemen,
  });

  factory CountNotif.fromJson(Map<String, dynamic> json) => CountNotif(
        pengajuanDepartemen: json['pengajuan_departemen'] == null
            ? null
            : PengajuanDepartemen.fromJson(
                json['pengajuan_departemen'] as Map<String, dynamic>),
        ptjDepartemen: json['ptj_departemen'] == null
            ? null
            : PtjDepartemen.fromJson(
                json['ptj_departemen'] as Map<String, dynamic>),
        logistik: json['logistik'] == null
            ? null
            : LogistikCount.fromJson(json['logistik'] as Map<String, dynamic>),
        rabDepartemen: json['rab_departemen'] == null
            ? null
            : RabDepartemen.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        'pengajuan_departemen': pengajuanDepartemen?.toJson(),
        'ptj_departemen': ptjDepartemen?.toJson(),
        'logistik': logistik?.toJson(), // ← tambahkan
        'rab_departemen': rabDepartemen?.toJson(),
      };

  static List<CountNotif> fromJsonList(List? data) {
    return (data ?? []).map((e) => CountNotif.fromJson(e)).toList();
  }
}
