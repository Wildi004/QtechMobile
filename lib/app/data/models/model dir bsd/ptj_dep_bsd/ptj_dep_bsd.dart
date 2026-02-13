import 'detail.dart';

class PtjDepBsd {
  int? id;
  String? noPtjReg;
  String? tglPtj;
  int? regionalId;
  int? total;
  int? statusDirKeuangan;
  String? noHide;
  String? createdName;
  dynamic approvedName;
  String? regionalName;
  List<DetailPtjDep>? detail;

  PtjDepBsd({
    this.id,
    this.noPtjReg,
    this.tglPtj,
    this.regionalId,
    this.total,
    this.statusDirKeuangan,
    this.noHide,
    this.createdName,
    this.approvedName,
    this.regionalName,
    this.detail,
  });

  factory PtjDepBsd.fromJson(Map<String, dynamic> json) => PtjDepBsd(
        id: json['id'] as int?,
        noPtjReg: json['no_ptj_reg'] as String?,
        tglPtj: json['tgl_ptj'] as String?,
        regionalId: json['regional_id'] as int?,
        total: json['total'] as int?,
        statusDirKeuangan: json['status_dir_keuangan'] as int?,
        noHide: json['no_hide'] as String?,
        createdName: json['created_name'] as String?,
        approvedName: json['approved_name'] as dynamic,
        regionalName: json['regional_name'] as String?,
        detail: (json['detail'] as List<dynamic>?)
            ?.map((e) => DetailPtjDep.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_ptj_reg': noPtjReg,
        'tgl_ptj': tglPtj,
        'regional_id': regionalId,
        'total': total,
        'status_dir_keuangan': statusDirKeuangan,
        'no_hide': noHide,
        'created_name': createdName,
        'approved_name': approvedName,
        'regional_name': regionalName,
        'detail': detail?.map((e) => e.toJson()).toList(),
      };

  static List<PtjDepBsd> fromJsonList(List? data) {
    return (data ?? []).map((e) => PtjDepBsd.fromJson(e)).toList();
  }
}
