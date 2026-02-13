import 'alat.dart';

class ValidasiAlat {
  int? id;
  String? transKode;
  int? alatId;
  String? fromDate;
  String? toDate;
  int? lamaHari;
  int? statusPm;
  int? validasiPm;
  int? pm;
  int? statusLogistik;
  int? validasiLogistik;
  int? statusGmRegional;
  int? validasiGm;
  String? noPengajuan;
  String? tglPengajuan;
  String? kodeProyek;
  String? uraianPekerjaan;
  String? spv;
  dynamic detailProyekItem;
  Alat? alat;

  ValidasiAlat({
    this.id,
    this.transKode,
    this.alatId,
    this.fromDate,
    this.toDate,
    this.lamaHari,
    this.statusPm,
    this.validasiPm,
    this.pm,
    this.statusLogistik,
    this.validasiLogistik,
    this.statusGmRegional,
    this.validasiGm,
    this.noPengajuan,
    this.tglPengajuan,
    this.kodeProyek,
    this.uraianPekerjaan,
    this.spv,
    this.detailProyekItem,
    this.alat,
  });

  factory ValidasiAlat.fromJson(Map<String, dynamic> json) => ValidasiAlat(
        id: json['id'] as int?,
        transKode: json['trans_kode'] as String?,
        alatId: json['alat_id'] as int?,
        fromDate: json['from_date'] as String?,
        toDate: json['to_date'] as String?,
        lamaHari: json['lama_hari'] as int?,
        statusPm: json['status_pm'] as int?,
        validasiPm: json['validasi_pm'] as int?,
        pm: json['pm'] as int?,
        statusLogistik: json['status_logistik'] as int?,
        validasiLogistik: json['validasi_logistik'] as int?,
        statusGmRegional: json['status_gm_regional'] as int?,
        validasiGm: json['validasi_gm'] as int?,
        noPengajuan: json['no_pengajuan'] as String?,
        tglPengajuan: json['tgl_pengajuan'] as String?,
        kodeProyek: json['kode_proyek'] as String?,
        uraianPekerjaan: json['uraian_pekerjaan'] as String?,
        spv: json['spv'] as String?,
        detailProyekItem: json['detail_proyek_item'] as dynamic,
        alat: json['alat'] == null
            ? null
            : Alat.fromJson(json['alat'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'trans_kode': transKode,
        'alat_id': alatId,
        'from_date': fromDate,
        'to_date': toDate,
        'lama_hari': lamaHari,
        'status_pm': statusPm,
        'validasi_pm': validasiPm,
        'pm': pm,
        'status_logistik': statusLogistik,
        'validasi_logistik': validasiLogistik,
        'status_gm_regional': statusGmRegional,
        'validasi_gm': validasiGm,
        'no_pengajuan': noPengajuan,
        'tgl_pengajuan': tglPengajuan,
        'kode_proyek': kodeProyek,
        'uraian_pekerjaan': uraianPekerjaan,
        'spv': spv,
        'detail_proyek_item': detailProyekItem,
        'alat': alat?.toJson(),
      };

  static List<ValidasiAlat> fromJsonList(List? data) {
    return (data ?? []).map((e) => ValidasiAlat.fromJson(e)).toList();
  }
}
