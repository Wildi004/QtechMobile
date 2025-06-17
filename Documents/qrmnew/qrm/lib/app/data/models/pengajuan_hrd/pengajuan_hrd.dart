import 'package:qrm/app/data/models/pengajuan_hrd/detail_history.dart';

class PengajuanHrd {
  int? id;
  String? noPengajuan;
  String? tglPengajuan;
  int? depId;
  int? subTotal;
  int? statusGmBsd;
  int? statusDirKeuangan;
  int? approval;
  int? approvedBy;
  int? createdBy;
  int? createdAt;
  String? noHide;
  int? updatedBy;
  int? sttsCheck;
  String? createdName;
  String? updatedName;
  dynamic approvalName;
  dynamic aprrovedByName;
  String? depName;
  List<DetailHistory>? detail;

  PengajuanHrd({
    this.id,
    this.noPengajuan,
    this.tglPengajuan,
    this.depId,
    this.subTotal,
    this.statusGmBsd,
    this.statusDirKeuangan,
    this.approval,
    this.approvedBy,
    this.createdBy,
    this.createdAt,
    this.noHide,
    this.updatedBy,
    this.sttsCheck,
    this.createdName,
    this.updatedName,
    this.approvalName,
    this.aprrovedByName,
    this.depName,
    this.detail,
  });

  factory PengajuanHrd.fromJson(Map<String, dynamic> json) => PengajuanHrd(
        id: json['id'] as int?,
        noPengajuan: json['no_pengajuan'] as String?,
        tglPengajuan: json['tgl_pengajuan'] as String?,
        depId: json['dep_id'] as int?,
        subTotal: json['sub_total'] as int?,
        statusGmBsd: json['status_gm_bsd'] as int?,
        statusDirKeuangan: json['status_dir_keuangan'] as int?,
        approval: json['approval'] as int?,
        approvedBy: json['approved_by'] as int?,
        createdBy: json['created_by'] as int?,
        createdAt: json['created_at'] as int?,
        noHide: json['no_hide'] as String?,
        updatedBy: json['updated_by'] as int?,
        sttsCheck: json['stts_check'] as int?,
        createdName: json['created_name'] as String?,
        updatedName: json['updated_name'] as String?,
        approvalName: json['approval_name'] as dynamic,
        aprrovedByName: json['aprroved_by_name'] as dynamic,
        depName: json['dep_name'] as String?,
        detail: (json['detail'] as List<dynamic>?)
            ?.map((e) => DetailHistory.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_pengajuan': noPengajuan,
        'tgl_pengajuan': tglPengajuan,
        'dep_id': depId,
        'sub_total': subTotal,
        'status_gm_bsd': statusGmBsd,
        'status_dir_keuangan': statusDirKeuangan,
        'approval': approval,
        'approved_by': approvedBy,
        'created_by': createdBy,
        'created_at': createdAt,
        'no_hide': noHide,
        'updated_by': updatedBy,
        'stts_check': sttsCheck,
        'created_name': createdName,
        'updated_name': updatedName,
        'approval_name': approvalName,
        'aprroved_by_name': aprrovedByName,
        'dep_name': depName,
        'detail': detail?.map((e) => e.toJson()).toList(),
      };

  static List<PengajuanHrd> fromJsonList(List? data) {
    return (data ?? []).map((e) => PengajuanHrd.fromJson(e)).toList();
  }
}
