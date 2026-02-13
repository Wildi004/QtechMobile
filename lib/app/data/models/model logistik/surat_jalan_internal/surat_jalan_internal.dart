import 'detail.dart';

class SuratJalanInternal {
  int? id;
  String? noBukti;
  String? ditujukan;
  String? tgl;
  String? noPengajuan;
  String? tujuan;
  String? kodeProyek;
  int? proyekItemId;
  String? namaProyek;
  String? total;
  String? keterangan;
  int? yangMenyerahkan;
  int? statusGmBali;
  int? approval;
  int? statusDir;
  int? approvedBy;
  String? noHide;
  int? createdAt;
  int? subTotal;
  String? bagLogistik;
  String? ttd;
  List<DetailSuratJalanInternal>? detail;

  SuratJalanInternal({
    this.id,
    this.noBukti,
    this.ditujukan,
    this.tgl,
    this.noPengajuan,
    this.tujuan,
    this.kodeProyek,
    this.proyekItemId,
    this.namaProyek,
    this.total,
    this.keterangan,
    this.yangMenyerahkan,
    this.statusGmBali,
    this.approval,
    this.statusDir,
    this.approvedBy,
    this.noHide,
    this.createdAt,
    this.subTotal,
    this.bagLogistik,
    this.ttd,
    this.detail,
  });

  factory SuratJalanInternal.fromJson(Map<String, dynamic> json) {
    return SuratJalanInternal(
      id: json['id'] as int?,
      noBukti: json['no_bukti'] as String?,
      ditujukan: json['ditujukan'] as String?,
      tgl: json['tgl'] as String?,
      noPengajuan: json['no_pengajuan'] as String?,
      tujuan: json['tujuan'] as String?,
      kodeProyek: json['kode_proyek'] as String?,
      proyekItemId: int.tryParse(json['proyek_item_id'].toString()),
      namaProyek: json['nama_proyek'] as String?,
      total: json['total'].toString(),
      keterangan: json['keterangan'] as String?,
      yangMenyerahkan: int.tryParse(json['yang_menyerahkan'].toString()),
      statusGmBali: int.tryParse(
          (json['status_gm_bali'] ?? json['status_gm_jkt']).toString()),
      approval: int.tryParse(json['approval'].toString()),
      statusDir: int.tryParse(json['status_dir'].toString()),
      approvedBy: int.tryParse(json['approved_by'].toString()),
      noHide: json['no_hide'] as String?,
      createdAt: int.tryParse(json['created_at'].toString()),
      subTotal: int.tryParse(json['sub_total'].toString()),
      bagLogistik: json['bag_logistik'] as String?,
      ttd: json['ttd'] as String?,
      detail: (json['detail'] as List<dynamic>?)
          ?.map((e) => DetailSuratJalanInternal.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_bukti': noBukti,
        'ditujukan': ditujukan,
        'tgl': tgl,
        'no_pengajuan': noPengajuan,
        'tujuan': tujuan,
        'kode_proyek': kodeProyek,
        'proyek_item_id': proyekItemId,
        'nama_proyek': namaProyek,
        'total': total,
        'keterangan': keterangan,
        'yang_menyerahkan': yangMenyerahkan,
        'status_gm_bali': statusGmBali,
        'approval': approval,
        'status_dir': statusDir,
        'approved_by': approvedBy,
        'no_hide': noHide,
        'created_at': createdAt,
        'sub_total': subTotal,
        'bag_logistik': bagLogistik,
        'ttd': ttd,
        'detail': detail?.map((e) => e.toJson()).toList(),
      };

  static List<SuratJalanInternal> fromJsonList(List? data) {
    return (data ?? []).map((e) => SuratJalanInternal.fromJson(e)).toList();
  }
}
