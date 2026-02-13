import 'detail.dart';

class DelPoNonPpn {
  int? id;
  String? noDelivery;
  String? noPo;
  String? shipmentDate;
  String? receivedDate;
  String? lokasiKirim;
  String? penerima;
  String? ekspedisi;
  String? totalBerat;
  String? hargaEkspedisi;
  int? createdBy;
  int? approval;
  int? statusGmRegional;
  int? approvedBy;
  int? statusDirKeuangan;
  int? createdAt;
  String? noHide;
  String? createdByName;
  String? approvalName;
  dynamic approvedByName;
  List<DetailDelPoNon>? detail;

  DelPoNonPpn({
    this.id,
    this.noDelivery,
    this.noPo,
    this.shipmentDate,
    this.receivedDate,
    this.lokasiKirim,
    this.penerima,
    this.ekspedisi,
    this.totalBerat,
    this.hargaEkspedisi,
    this.createdBy,
    this.approval,
    this.statusGmRegional,
    this.approvedBy,
    this.statusDirKeuangan,
    this.createdAt,
    this.noHide,
    this.createdByName,
    this.approvalName,
    this.approvedByName,
    this.detail,
  });

  factory DelPoNonPpn.fromJson(Map<String, dynamic> json) => DelPoNonPpn(
        id: json['id'] as int?,
        noDelivery: json['no_delivery'] as String?,
        noPo: json['no_po'] as String?,
        shipmentDate: json['shipment_date'] as String?,
        receivedDate: json['received_date'] as String?,
        lokasiKirim: json['lokasi_kirim'] as String?,
        penerima: json['penerima'] as String?,
        ekspedisi: json['ekspedisi'] as String?,
        totalBerat: json['total_berat'] as String?,
        hargaEkspedisi: json['harga_ekspedisi'] as String?,
        createdBy: json['created_by'] as int?,
        approval: json['approval'] as int?,
        statusGmRegional: json['status_gm_regional'] as int?,
        approvedBy: json['approved_by'] as int?,
        statusDirKeuangan: json['status_dir_keuangan'] as int?,
        createdAt: json['created_at'] as int?,
        noHide: json['no_hide'] as String?,
        createdByName: json['created_by_name'] as String?,
        approvalName: json['approval_name'] as String?,
        approvedByName: json['approved_by_name'] as dynamic,
        detail: (json['detail'] as List<dynamic>?)
            ?.map((e) => DetailDelPoNon.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_delivery': noDelivery,
        'no_po': noPo,
        'shipment_date': shipmentDate,
        'received_date': receivedDate,
        'lokasi_kirim': lokasiKirim,
        'penerima': penerima,
        'ekspedisi': ekspedisi,
        'total_berat': totalBerat,
        'harga_ekspedisi': hargaEkspedisi,
        'created_by': createdBy,
        'approval': approval,
        'status_gm_regional': statusGmRegional,
        'approved_by': approvedBy,
        'status_dir_keuangan': statusDirKeuangan,
        'created_at': createdAt,
        'no_hide': noHide,
        'created_by_name': createdByName,
        'approval_name': approvalName,
        'approved_by_name': approvedByName,
        'detail': detail?.map((e) => e.toJson()).toList(),
      };

  static List<DelPoNonPpn> fromJsonList(List? data) {
    return (data ?? []).map((e) => DelPoNonPpn.fromJson(e)).toList();
  }
}
