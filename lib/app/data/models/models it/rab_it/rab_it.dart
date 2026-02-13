import 'rab_detail.dart';

class RabIt {
  int? id;
  String? kodeRab;
  String? periode;
  String? grandtotal;
  int? statusBsd;
  String? departemenName;
  String? createdByName;
  dynamic approvalName;
  List<RabDetailIt>? rabDetail;

  RabIt({
    this.id,
    this.kodeRab,
    this.periode,
    this.grandtotal,
    this.statusBsd,
    this.departemenName,
    this.createdByName,
    this.approvalName,
    this.rabDetail,
  });

  factory RabIt.fromJson(Map<String, dynamic> json) => RabIt(
        id: json['id'] as int?,
        kodeRab: json['kode_rab'] as String?,
        periode: json['periode'] as String?,
        grandtotal: json['grandtotal'] as String?,
        statusBsd: json['status_bsd'] as int?,
        departemenName: json['departemen_name'] as String?,
        createdByName: json['created_by_name'] as String?,
        approvalName: json['approval_name'] as dynamic,
        rabDetail: (json['rab_detail'] as List<dynamic>?)
            ?.map((e) => RabDetailIt.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_rab': kodeRab,
        'periode': periode,
        'grandtotal': grandtotal,
        'status_bsd': statusBsd,
        'departemen_name': departemenName,
        'created_by_name': createdByName,
        'approval_name': approvalName,
        'rab_detail': rabDetail?.map((e) => e.toJson()).toList(),
      };

  static List<RabIt> fromJsonList(List? data) {
    return (data ?? []).map((e) => RabIt.fromJson(e)).toList();
  }
}
