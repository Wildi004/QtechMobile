import 'detail.dart';

class Pengajuan {
  int? id;
  String? noPengajuan;
  String? tglPengajuan;
  int? subTotal;
  int? statusGmBsd;
  int? statusDirKeuangan;
  String? noHide;
  int? updatedBy;
  String? createdName;
  String? updatedName;
  dynamic approvalName;
  dynamic aprrovedByName;
  String? depName;
  List<DetailPengajuan>? detail;

  Pengajuan({
    this.id,
    this.noPengajuan,
    this.tglPengajuan,
    this.subTotal,
    this.statusGmBsd,
    this.statusDirKeuangan,
    this.noHide,
    this.updatedBy,
    this.createdName,
    this.updatedName,
    this.approvalName,
    this.aprrovedByName,
    this.depName,
    this.detail,
  });

  factory Pengajuan.fromJson(Map<String, dynamic> json) => Pengajuan(
        id: json['id'] as int?,
        noPengajuan: json['no_pengajuan'] as String?,
        tglPengajuan: json['tgl_pengajuan'] as String?,
        subTotal: json['sub_total'] as int?,
        statusGmBsd: json['status_gm_bsd'] as int?,
        statusDirKeuangan: json['status_dir_keuangan'] as int?,
        noHide: json['no_hide'] as String?,
        updatedBy: json['updated_by'] as int?,
        createdName: json['created_name'] as String?,
        updatedName: json['updated_name'] as String?,
        approvalName: json['approval_name'] as dynamic,
        aprrovedByName: json['aprroved_by_name'] as dynamic,
        depName: json['dep_name'] as String?,
        detail: (json['detail'] as List<dynamic>?)
            ?.map((e) => DetailPengajuan.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_pengajuan': noPengajuan,
        'tgl_pengajuan': tglPengajuan,
        'sub_total': subTotal,
        'status_gm_bsd': statusGmBsd,
        'status_dir_keuangan': statusDirKeuangan,
        'no_hide': noHide,
        'updated_by': updatedBy,
        'created_name': createdName,
        'updated_name': updatedName,
        'approval_name': approvalName,
        'aprroved_by_name': aprrovedByName,
        'dep_name': depName,
        'detail': detail?.map((e) => e.toJson()).toList(),
      };

  static List<Pengajuan> fromJsonList(List? data) {
    return (data ?? []).map((e) => Pengajuan.fromJson(e)).toList();
  }
}
