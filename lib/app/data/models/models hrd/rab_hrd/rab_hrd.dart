import 'rab_detail.dart';

class RabHrd {
  int? id;
  String? kodeRab;
  String? periode;
  String? grandtotal;
  int? statusBsd;
  int? createdAt;
  String? departemenName;
  String? createdByName;
  dynamic approvalName;
  List<RabDetail>? rabDetail;

  RabHrd({
    this.id,
    this.kodeRab,
    this.periode,
    this.grandtotal,
    this.statusBsd,
    this.createdAt,
    this.departemenName,
    this.createdByName,
    this.approvalName,
    this.rabDetail,
  });

  factory RabHrd.fromJson(Map<String, dynamic> json) => RabHrd(
        id: json['id'] as int?,
        kodeRab: json['kode_rab'] as String?,
        periode: json['periode'] as String?,
        grandtotal: json['grandtotal'] as String?,
        statusBsd: json['status_bsd'] as int?,
        createdAt: json['created_at'] as int?,
        departemenName: json['departemen_name'] as String?,
        createdByName: json['created_by_name'] as String?,
        approvalName: json['approval_name'] as dynamic,
        rabDetail: (json['rab_detail'] as List<dynamic>?)
            ?.map((e) => RabDetail.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_rab': kodeRab,
        'periode': periode,
        'grandtotal': grandtotal,
        'status_bsd': statusBsd,
        'created_at': createdAt,
        'departemen_name': departemenName,
        'created_by_name': createdByName,
        'approval_name': approvalName,
        'rab_detail': rabDetail?.map((e) => e.toJson()).toList(),
      };

  static List<RabHrd> fromJsonList(List? data) {
    return (data ?? []).map((e) => RabHrd.fromJson(e)).toList();
  }
}
