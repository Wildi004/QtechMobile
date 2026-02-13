import 'detail.dart';

class KasbonDepBsd {
  int? id;
  String? noPengajuanReg;
  String? tglPengajuan;
  int? regionalId;
  int? total;
  int? statusDirKeuangan;
  String? createdIn;
  String? noHide;
  String? type;
  int? updatedBy;
  String? createdName;
  dynamic updatedName;
  dynamic aprrovedByName;
  String? depName;
  String? regionalName;
  List<DetailKason>? detail;

  KasbonDepBsd({
    this.id,
    this.noPengajuanReg,
    this.tglPengajuan,
    this.regionalId,
    this.total,
    this.statusDirKeuangan,
    this.createdIn,
    this.noHide,
    this.type,
    this.updatedBy,
    this.createdName,
    this.updatedName,
    this.aprrovedByName,
    this.depName,
    this.regionalName,
    this.detail,
  });

  factory KasbonDepBsd.fromJson(Map<String, dynamic> json) => KasbonDepBsd(
        id: json['id'] as int?,
        noPengajuanReg: json['no_pengajuan_reg'] as String?,
        tglPengajuan: json['tgl_pengajuan'] as String?,
        regionalId: json['regional_id'] as int?,
        total: json['total'] as int?,
        statusDirKeuangan: json['status_dir_keuangan'] as int?,
        createdIn: json['created_in'] as String?,
        noHide: json['no_hide'] as String?,
        type: json['type'] as String?,
        updatedBy: json['updated_by'] as int?,
        createdName: json['created_name'] as String?,
        updatedName: json['updated_name'] as dynamic,
        aprrovedByName: json['aprroved_by_name'] as dynamic,
        depName: json['dep_name'] as String?,
        regionalName: json['regional_name'] as String?,
        detail: (json['detail'] as List<dynamic>?)
            ?.map((e) => DetailKason.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_pengajuan_reg': noPengajuanReg,
        'tgl_pengajuan': tglPengajuan,
        'regional_id': regionalId,
        'total': total,
        'status_dir_keuangan': statusDirKeuangan,
        'created_in': createdIn,
        'no_hide': noHide,
        'type': type,
        'updated_by': updatedBy,
        'created_name': createdName,
        'updated_name': updatedName,
        'aprroved_by_name': aprrovedByName,
        'dep_name': depName,
        'regional_name': regionalName,
        'detail': detail?.map((e) => e.toJson()).toList(),
      };

  static List<KasbonDepBsd> fromJsonList(List? data) {
    return (data ?? []).map((e) => KasbonDepBsd.fromJson(e)).toList();
  }
}
