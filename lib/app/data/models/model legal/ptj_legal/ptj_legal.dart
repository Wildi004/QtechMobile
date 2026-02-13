import 'detail_ptj.dart';

class PtjLegal {
  int? id;
  String? noPtj;
  String? tglPtj;
  String? total;
  int? statusDirKeuangan;
  int? statusGmBsd;
  String? noHide;
  String? type;
  String? createdName;
  String? approvedName;
  String? approvalName;
  String? depName;
  List<DetailPtjLegal>? detailPtj;

  PtjLegal({
    this.id,
    this.noPtj,
    this.tglPtj,
    this.total,
    this.statusDirKeuangan,
    this.statusGmBsd,
    this.noHide,
    this.type,
    this.createdName,
    this.approvedName,
    this.approvalName,
    this.depName,
    this.detailPtj,
  });

  factory PtjLegal.fromJson(Map<String, dynamic> json) => PtjLegal(
        id: json['id'] as int?,
        noPtj: json['no_ptj'] as String?,
        tglPtj: json['tgl_ptj'] as String?,
        total: json['total'] as String?,
        statusDirKeuangan: json['status_dir_keuangan'] as int?,
        statusGmBsd: json['status_gm_bsd'] as int?,
        noHide: json['no_hide'] as String?,
        type: json['type'] as String?,
        createdName: json['created_name'] as String?,
        approvedName: json['approved_name'] as String?,
        approvalName: json['approval_name'] as String?,
        depName: json['dep_name'] as String?,
        detailPtj: (json['detail_ptj'] as List<dynamic>?)
            ?.map((e) => DetailPtjLegal.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_ptj': noPtj,
        'tgl_ptj': tglPtj,
        'total': total,
        'status_dir_keuangan': statusDirKeuangan,
        'status_gm_bsd': statusGmBsd,
        'no_hide': noHide,
        'type': type,
        'created_name': createdName,
        'approved_name': approvedName,
        'approval_name': approvalName,
        'dep_name': depName,
        'detail_ptj': detailPtj?.map((e) => e.toJson()).toList(),
      };

  static List<PtjLegal> fromJsonList(List? data) {
    return (data ?? []).map((e) => PtjLegal.fromJson(e)).toList();
  }
}
