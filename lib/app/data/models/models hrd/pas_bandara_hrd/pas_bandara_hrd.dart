import 'detail_orang.dart';

class PasBandaraHrd {
  String? kodeProyek;
  dynamic proyekItemName;
  int? id;
  String? noPengajuan;
  String? kodePengajuan;
  String? jenisPas;
  String? masaBerlaku;
  String? tglPengajuan;
  int? statusGm;
  String? regional;
  int? createdAt;
  String? pmName;
  String? approvedByName;
  String? dep;
  List<DetailOrang>? detailOrang;
  List<dynamic>? detailTim;
  List<dynamic>? detailKendaraan;

  PasBandaraHrd({
    this.kodeProyek,
    this.proyekItemName,
    this.id,
    this.noPengajuan,
    this.kodePengajuan,
    this.jenisPas,
    this.masaBerlaku,
    this.tglPengajuan,
    this.statusGm,
    this.regional,
    this.createdAt,
    this.pmName,
    this.approvedByName,
    this.dep,
    this.detailOrang,
    this.detailTim,
    this.detailKendaraan,
  });

  factory PasBandaraHrd.fromJson(Map<String, dynamic> json) => PasBandaraHrd(
        kodeProyek: json['kode_proyek'] as String?,
        proyekItemName: json['proyek_item_name'] as dynamic,
        id: json['id'] as int?,
        noPengajuan: json['no_pengajuan'] as String?,
        kodePengajuan: json['kode_pengajuan'] as String?,
        jenisPas: json['jenis_pas'] as String?,
        masaBerlaku: json['masa_berlaku'] as String?,
        tglPengajuan: json['tgl_pengajuan'] as String?,
        statusGm: json['status_gm'] as int?,
        regional: json['regional'] as String?,
        createdAt: json['created_at'] as int?,
        pmName: json['pm_name'] as String?,
        approvedByName: json['approved_by_name'] as String?,
        dep: json['dep'] as String?,
        detailOrang: (json['detail_orang'] as List<dynamic>?)
            ?.map((e) => DetailOrang.fromJson(e as Map<String, dynamic>))
            .toList(),
        detailTim: json['detail_tim'] as List<dynamic>?,
        detailKendaraan: json['detail_kendaraan'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'kode_proyek': kodeProyek,
        'proyek_item_name': proyekItemName,
        'id': id,
        'no_pengajuan': noPengajuan,
        'kode_pengajuan': kodePengajuan,
        'jenis_pas': jenisPas,
        'masa_berlaku': masaBerlaku,
        'tgl_pengajuan': tglPengajuan,
        'status_gm': statusGm,
        'regional': regional,
        'created_at': createdAt,
        'pm_name': pmName,
        'approved_by_name': approvedByName,
        'dep': dep,
        'detail_orang': detailOrang?.map((e) => e.toJson()).toList(),
        'detail_tim': detailTim,
        'detail_kendaraan': detailKendaraan,
      };

  static List<PasBandaraHrd> fromJsonList(List? data) {
    return (data ?? []).map((e) => PasBandaraHrd.fromJson(e)).toList();
  }
}
