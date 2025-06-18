import 'detail_ptj.dart';

class PtjHrd {
  int? id;
  String? noPtj;
  String? tglPtj;
  int? depId;
  String? total;
  int? createdBy;
  int? approvedBy;
  int? statusDirKeuangan;
  int? approval;
  int? statusGmBsd;
  int? createdAt;
  String? noHide;
  int? sttsCheck;
  String? type;
  String? createdName;
  String? approvedName;
  String? approvalName;
  String? depName;
  List<DetailPtj>? detailPtj;

  PtjHrd({
    this.id,
    this.noPtj,
    this.tglPtj,
    this.depId,
    this.total,
    this.createdBy,
    this.approvedBy,
    this.statusDirKeuangan,
    this.approval,
    this.statusGmBsd,
    this.createdAt,
    this.noHide,
    this.sttsCheck,
    this.type,
    this.createdName,
    this.approvedName,
    this.approvalName,
    this.depName,
    this.detailPtj,
  });

  factory PtjHrd.fromJson(Map<String, dynamic> json) => PtjHrd(
        id: json['id'] as int?,
        noPtj: json['no_ptj'] as String?,
        tglPtj: json['tgl_ptj'] as String?,
        depId: json['dep_id'] as int?,
        total: json['total'] as String?,
        createdBy: json['created_by'] as int?,
        approvedBy: json['approved_by'] as int?,
        statusDirKeuangan: json['status_dir_keuangan'] as int?,
        approval: json['approval'] as int?,
        statusGmBsd: json['status_gm_bsd'] as int?,
        createdAt: json['created_at'] as int?,
        noHide: json['no_hide'] as String?,
        sttsCheck: json['stts_check'] as int?,
        type: json['type'] as String?,
        createdName: json['created_name'] as String?,
        approvedName: json['approved_name'] as String?,
        approvalName: json['approval_name'] as String?,
        depName: json['dep_name'] as String?,
        detailPtj: (json['detail_ptj'] as List<dynamic>?)
            ?.map((e) => DetailPtj.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_ptj': noPtj,
        'tgl_ptj': tglPtj,
        'dep_id': depId,
        'total': total,
        'created_by': createdBy,
        'approved_by': approvedBy,
        'status_dir_keuangan': statusDirKeuangan,
        'approval': approval,
        'status_gm_bsd': statusGmBsd,
        'created_at': createdAt,
        'no_hide': noHide,
        'stts_check': sttsCheck,
        'type': type,
        'created_name': createdName,
        'approved_name': approvedName,
        'approval_name': approvalName,
        'dep_name': depName,
        'detail_ptj': detailPtj?.map((e) => e.toJson()).toList(),
      };

  static List<PtjHrd> fromJsonList(List? data) {
    return (data ?? []).map((e) => PtjHrd.fromJson(e)).toList();
  }
}
