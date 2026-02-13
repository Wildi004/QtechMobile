import 'detail.dart';

class InvDelPembNonPpn {
  int? id;
  String? noInvoice;
  String? tglInv;
  String? tglDibuat;
  int? suplierId;
  String? caraPembayaran;
  String? termFrom;
  String? termTo;
  int? lamaHari;
  String? noDelivery;
  String? subTotal;
  String? ppn;
  String? jmlPpn;
  String? grandtotal;
  String? noHide;
  String? catatan;
  int? createdBy;
  int? statusGm;
  int? approval;
  int? statusDirKeuangan;
  int? approvedBy;
  String? image;
  int? createdAt;
  String? createdByName;
  dynamic approvalName;
  dynamic approvedByName;
  String? suplierName;
  List<DetailInvDelPembNonPpn>? detail;

  InvDelPembNonPpn({
    this.id,
    this.noInvoice,
    this.tglInv,
    this.tglDibuat,
    this.suplierId,
    this.caraPembayaran,
    this.termFrom,
    this.termTo,
    this.lamaHari,
    this.noDelivery,
    this.subTotal,
    this.ppn,
    this.jmlPpn,
    this.grandtotal,
    this.noHide,
    this.catatan,
    this.createdBy,
    this.statusGm,
    this.approval,
    this.statusDirKeuangan,
    this.approvedBy,
    this.image,
    this.createdAt,
    this.createdByName,
    this.approvalName,
    this.approvedByName,
    this.suplierName,
    this.detail,
  });

  factory InvDelPembNonPpn.fromJson(Map<String, dynamic> json) {
    return InvDelPembNonPpn(
      id: json['id'] as int?,
      noInvoice: json['no_invoice'] as String?,
      tglInv: json['tgl_inv'] as String?,
      tglDibuat: json['tgl_dibuat'] as String?,
      suplierId: json['suplier_id'] as int?,
      caraPembayaran: json['cara_pembayaran'] as String?,
      termFrom: json['term_from'] as String?,
      termTo: json['term_to'] as String?,
      lamaHari: json['lama_hari'] as int?,
      noDelivery: json['no_delivery'] as String?,
      subTotal: json['sub_total'] as String?,
      ppn: json['ppn'] as String?,
      jmlPpn: json['jml_ppn'] as String?,
      grandtotal: json['grandtotal'] as String?,
      noHide: json['no_hide'] as String?,
      catatan: json['catatan'] as String?,
      createdBy: json['created_by'] as int?,
      statusGm: json['status_gm'] as int?,
      approval: json['approval'] as int?,
      statusDirKeuangan: json['status_dir_keuangan'] as int?,
      approvedBy: json['approved_by'] as int?,
      image: json['image'] as String?,
      createdAt: json['created_at'] as int?,
      createdByName: json['created_by_name'] as String?,
      approvalName: json['approval_name'] as dynamic,
      approvedByName: json['approved_by_name'] as dynamic,
      suplierName: json['suplier_name'] as String?,
      detail: (json['detail'] as List<dynamic>?)
          ?.map(
              (e) => DetailInvDelPembNonPpn.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_invoice': noInvoice,
        'tgl_inv': tglInv,
        'tgl_dibuat': tglDibuat,
        'suplier_id': suplierId,
        'cara_pembayaran': caraPembayaran,
        'term_from': termFrom,
        'term_to': termTo,
        'lama_hari': lamaHari,
        'no_delivery': noDelivery,
        'sub_total': subTotal,
        'ppn': ppn,
        'jml_ppn': jmlPpn,
        'grandtotal': grandtotal,
        'no_hide': noHide,
        'catatan': catatan,
        'created_by': createdBy,
        'status_gm': statusGm,
        'approval': approval,
        'status_dir_keuangan': statusDirKeuangan,
        'approved_by': approvedBy,
        'image': image,
        'created_at': createdAt,
        'created_by_name': createdByName,
        'approval_name': approvalName,
        'approved_by_name': approvedByName,
        'suplier_name': suplierName,
        'detail': detail?.map((e) => e.toJson()).toList(),
      };

  static List<InvDelPembNonPpn> fromJsonList(List? data) {
    return (data ?? []).map((e) => InvDelPembNonPpn.fromJson(e)).toList();
  }
}
