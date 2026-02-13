import 'detail.dart';

class PembNonPpn {
  int? id;
  String? noPembelianNonppn;
  String? tglBeli;
  String? noInvoice;
  String? shipment;
  String? caraPembayaran;
  String? termFrom;
  String? termTo;
  int? lamaHari;
  String? jenisPembayaran;
  int? suplierId;
  String? subTotal;
  String? diskonTtl;
  String? biayaKirim;
  String? total;
  int? preparedBy;
  int? approvedBy;
  int? statusDirKeuangan;
  int? userSession;
  int? createdAt;
  String? noHide;
  String? preparedByName;
  dynamic approvedByName;
  String? userSessionName;
  String? suplierName;
  List<DetailPembNon>? detail;

  PembNonPpn({
    this.id,
    this.noPembelianNonppn,
    this.tglBeli,
    this.noInvoice,
    this.shipment,
    this.caraPembayaran,
    this.termFrom,
    this.termTo,
    this.lamaHari,
    this.jenisPembayaran,
    this.suplierId,
    this.subTotal,
    this.diskonTtl,
    this.biayaKirim,
    this.total,
    this.preparedBy,
    this.approvedBy,
    this.statusDirKeuangan,
    this.userSession,
    this.createdAt,
    this.noHide,
    this.preparedByName,
    this.approvedByName,
    this.userSessionName,
    this.suplierName,
    this.detail,
  });

  factory PembNonPpn.fromJson(Map<String, dynamic> json) => PembNonPpn(
        id: json['id'] as int?,
        noPembelianNonppn: json['no_pembelian_nonppn'] as String?,
        tglBeli: json['tgl_beli'] as String?,
        noInvoice: json['no_invoice'] as String?,
        shipment: json['shipment'] as String?,
        caraPembayaran: json['cara_pembayaran'] as String?,
        termFrom: json['term_from'] as String?,
        termTo: json['term_to'] as String?,
        lamaHari: json['lama_hari'] as int?,
        jenisPembayaran: json['jenis_pembayaran'] as String?,
        suplierId: json['suplier_id'] as int?,
        subTotal: json['sub_total'] as String?,
        diskonTtl: json['diskon_ttl'] as String?,
        biayaKirim: json['biaya_kirim'] as String?,
        total: json['total'] as String?,
        preparedBy: json['prepared_by'] as int?,
        approvedBy: json['approved_by'] as int?,
        statusDirKeuangan: json['status_dir_keuangan'] as int?,
        userSession: json['user_session'] as int?,
        createdAt: json['created_at'] as int?,
        noHide: json['no_hide'] as String?,
        preparedByName: json['prepared_by_name'] as String?,
        approvedByName: json['approved_by_name'] as dynamic,
        userSessionName: json['user_session_name'] as String?,
        suplierName: json['suplier_name'] as String?,
        detail: (json['detail'] as List<dynamic>?)
            ?.map((e) => DetailPembNon.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_pembelian_nonppn': noPembelianNonppn,
        'tgl_beli': tglBeli,
        'no_invoice': noInvoice,
        'shipment': shipment,
        'cara_pembayaran': caraPembayaran,
        'term_from': termFrom,
        'term_to': termTo,
        'lama_hari': lamaHari,
        'jenis_pembayaran': jenisPembayaran,
        'suplier_id': suplierId,
        'sub_total': subTotal,
        'diskon_ttl': diskonTtl,
        'biaya_kirim': biayaKirim,
        'total': total,
        'prepared_by': preparedBy,
        'approved_by': approvedBy,
        'status_dir_keuangan': statusDirKeuangan,
        'user_session': userSession,
        'created_at': createdAt,
        'no_hide': noHide,
        'prepared_by_name': preparedByName,
        'approved_by_name': approvedByName,
        'user_session_name': userSessionName,
        'suplier_name': suplierName,
        'detail': detail?.map((e) => e.toJson()).toList(),
      };

  static List<PembNonPpn> fromJsonList(List? data) {
    return (data ?? []).map((e) => PembNonPpn.fromJson(e)).toList();
  }
}
