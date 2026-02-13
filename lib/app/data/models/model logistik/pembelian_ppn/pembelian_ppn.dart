import 'detail.dart';

class PembelianPpn {
  int? id;
  String? noPembelian;
  String? shipment;
  String? tglBeli;
  String? noInvoice;
  String? caraPembayaran;
  String? termFrom;
  String? termTo;
  int? lamaHari;
  String? jenisPembayaran;
  int? suplierId;
  String? subTotal;
  String? diskonTtl;
  String? ppn;
  String? biayaKirim;
  String? total;
  int? preparedBy;
  int? approved;
  int? statusDirKeuangan;
  int? approval;
  int? statusGmRegional;
  int? createdAt;
  String? noHide;
  String? preparedByName;
  dynamic approvedName;
  dynamic approvalName;
  String? suplierName;
  List<DetailPembPpn>? detail;

  PembelianPpn({
    this.id,
    this.noPembelian,
    this.shipment,
    this.tglBeli,
    this.noInvoice,
    this.caraPembayaran,
    this.termFrom,
    this.termTo,
    this.lamaHari,
    this.jenisPembayaran,
    this.suplierId,
    this.subTotal,
    this.diskonTtl,
    this.ppn,
    this.biayaKirim,
    this.total,
    this.preparedBy,
    this.approved,
    this.statusDirKeuangan,
    this.approval,
    this.statusGmRegional,
    this.createdAt,
    this.noHide,
    this.preparedByName,
    this.approvedName,
    this.approvalName,
    this.suplierName,
    this.detail,
  });

  factory PembelianPpn.fromJson(Map<String, dynamic> json) => PembelianPpn(
        id: json['id'] as int?,
        noPembelian: json['no_pembelian'] as String?,
        shipment: json['shipment'] as String?,
        tglBeli: json['tgl_beli'] as String?,
        noInvoice: json['no_invoice'] as String?,
        caraPembayaran: json['cara_pembayaran'] as String?,
        termFrom: json['term_from'] as String?,
        termTo: json['term_to'] as String?,
        lamaHari: json['lama_hari'] as int?,
        jenisPembayaran: json['jenis_pembayaran'] as String?,
        suplierId: json['suplier_id'] as int?,
        subTotal: json['sub_total'] as String?,
        diskonTtl: json['diskon_ttl'] as String?,
        ppn: json['ppn'] as String?,
        biayaKirim: json['biaya_kirim'] as String?,
        total: json['total'] as String?,
        preparedBy: json['prepared_by'] as int?,
        approved: json['approved'] as int?,
        statusDirKeuangan: json['status_dir_keuangan'] as int?,
        approval: json['approval'] as int?,
        statusGmRegional: json['status_gm_regional'] as int?,
        createdAt: json['created_at'] as int?,
        noHide: json['no_hide'] as String?,
        preparedByName: json['prepared_by_name'] as String?,
        approvedName: json['approved_name'] as dynamic,
        approvalName: json['approval_name'] as dynamic,
        suplierName: json['suplier_name'] as String?,
        detail: (json['detail'] is List)
            ? (json['detail'] as List)
                .map((e) => DetailPembPpn.fromJson(e as Map<String, dynamic>))
                .toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_pembelian': noPembelian,
        'shipment': shipment,
        'tgl_beli': tglBeli,
        'no_invoice': noInvoice,
        'cara_pembayaran': caraPembayaran,
        'term_from': termFrom,
        'term_to': termTo,
        'lama_hari': lamaHari,
        'jenis_pembayaran': jenisPembayaran,
        'suplier_id': suplierId,
        'sub_total': subTotal,
        'diskon_ttl': diskonTtl,
        'ppn': ppn,
        'biaya_kirim': biayaKirim,
        'total': total,
        'prepared_by': preparedBy,
        'approved': approved,
        'status_dir_keuangan': statusDirKeuangan,
        'approval': approval,
        'status_gm_regional': statusGmRegional,
        'created_at': createdAt,
        'no_hide': noHide,
        'prepared_by_name': preparedByName,
        'approved_name': approvedName,
        'approval_name': approvalName,
        'suplier_name': suplierName,
        'detail': detail?.map((e) => e.toJson()).toList(),
      };

  static List<PembelianPpn> fromJsonList(List? data) {
    return (data ?? []).map((e) => PembelianPpn.fromJson(e)).toList();
  }
}
