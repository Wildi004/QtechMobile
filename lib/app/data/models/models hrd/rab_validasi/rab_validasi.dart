import 'rab_detail.dart';

class RabValidasi {
  int? id;
  String? kodeRab;
  String? periode;
  String? grandtotal;
  int? statusBsd;
  String? departemenName;
  String? createdByName;
  String? approvalName;
  List<RabValidasiDetail>? rabDetail;

  RabValidasi({
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

  factory RabValidasi.fromJson(Map<String, dynamic> json) => RabValidasi(
        id: json['id'] as int?,
        kodeRab: json['kode_rab'] as String?,
        periode: json['periode'] as String?,
        grandtotal: json['grandtotal'] as String?,
        statusBsd: json['status_bsd'] as int?,
        departemenName: json['departemen_name'] as String?,
        createdByName: json['created_by_name'] as String?,
        approvalName: json['approval_name'] as String?,
        rabDetail: (json['rab_detail'] as List<dynamic>?)
            ?.map((e) => RabValidasiDetail.fromJson(e as Map<String, dynamic>))
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

  static List<RabValidasi> fromJsonList(List? data) {
    return (data ?? []).map((e) => RabValidasi.fromJson(e)).toList();
  }
}
