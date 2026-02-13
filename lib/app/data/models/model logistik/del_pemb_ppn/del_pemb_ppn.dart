import 'detail.dart';

class DelPembPpn {
  int? id;
  String? noDelivery;
  String? noPembelian;
  String? shipmentDate;
  String? receivedDate;
  String? ekspedisi;
  String? penerima;
  String? lokasiPengiriman;
  int? totalBerat;
  int? hargaEkspedisi;
  int? createdBy;
  int? approval;
  int? statusGmRegional;
  int? approvedBy;
  int? statusDirKeuangan;
  int? createdAt;
  String? noHide;
  String? createdByName;
  String? approvalName;
  String? approvedByName;
  List<DetailDelPembPpn>? detail;

  DelPembPpn({
    this.id,
    this.noDelivery,
    this.noPembelian,
    this.shipmentDate,
    this.receivedDate,
    this.ekspedisi,
    this.penerima,
    this.lokasiPengiriman,
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

  factory DelPembPpn.fromJson(Map<String, dynamic> json) => DelPembPpn(
        id: json['id'] as int?,
        noDelivery: json['no_delivery'] as String?,
        noPembelian: json['no_pembelian'] as String?,
        shipmentDate: json['shipment_date'] as String?,
        receivedDate: json['received_date'] as String?,
        ekspedisi: json['ekspedisi'] as String?,
        penerima: json['penerima'] as String?,
        lokasiPengiriman: json['lokasi_pengiriman'] as String?,
        totalBerat: json['total_berat'] as int?,
        hargaEkspedisi: json['harga_ekspedisi'] as int?,
        createdBy: json['created_by'] as int?,
        approval: json['approval'] as int?,
        statusGmRegional: json['status_gm_regional'] as int?,
        approvedBy: json['approved_by'] as int?,
        statusDirKeuangan: json['status_dir_keuangan'] as int?,
        createdAt: json['created_at'] as int?,
        noHide: json['no_hide'] as String?,
        createdByName: json['created_by_name'] as String?,
        approvalName: json['approval_name'] as String?,
        approvedByName: json['approved_by_name'] as String?,
        detail: (json['detail'] as List<dynamic>?)
            ?.map((e) => DetailDelPembPpn.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_delivery': noDelivery,
        'no_pembelian': noPembelian,
        'shipment_date': shipmentDate,
        'received_date': receivedDate,
        'ekspedisi': ekspedisi,
        'penerima': penerima,
        'lokasi_pengiriman': lokasiPengiriman,
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

  static List<DelPembPpn> fromJsonList(List? data) {
    return (data ?? []).map((e) => DelPembPpn.fromJson(e)).toList();
  }
}
