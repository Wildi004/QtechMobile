import 'detail.dart';

class PoPpn {
  int? id;
  String? noPo;
  String? tglPo;
  String? deliveryDate;
  String? caraPembayaran;
  String? termFrom;
  String? termTo;
  int? lamaHari;
  String? jenisPembayaran;
  String? shipment;
  int? suplierId;
  String? lokasiPengiriman;
  int? subTotal;
  int? tax;
  int? freightCost;
  int? total;
  int? dp;
  int? jmlDp;
  String? catatan;
  String? kodeProyek;
  int? preparedBy;
  int? statusBsd;
  int? validasiBsd;
  int? statusDirKeuangan;
  int? approvedBy;
  int? createdAt;
  String? noHide;
  String? preparedByName;
  String? validasiBsdName;
  String? approvedByName;
  String? suplierName;
  List<DetailPpn>? detail;

  PoPpn({
    this.id,
    this.noPo,
    this.tglPo,
    this.deliveryDate,
    this.caraPembayaran,
    this.termFrom,
    this.termTo,
    this.lamaHari,
    this.jenisPembayaran,
    this.shipment,
    this.suplierId,
    this.lokasiPengiriman,
    this.subTotal,
    this.tax,
    this.freightCost,
    this.total,
    this.dp,
    this.jmlDp,
    this.catatan,
    this.kodeProyek,
    this.preparedBy,
    this.statusBsd,
    this.validasiBsd,
    this.statusDirKeuangan,
    this.approvedBy,
    this.createdAt,
    this.noHide,
    this.preparedByName,
    this.validasiBsdName,
    this.approvedByName,
    this.suplierName,
    this.detail,
  });

  factory PoPpn.fromJson(Map<String, dynamic> json) => PoPpn(
        id: json['id'] as int?,
        noPo: json['no_po'] as String?,
        tglPo: json['tgl_po'] as String?,
        deliveryDate: json['delivery_date'] as String?,
        caraPembayaran: json['cara_pembayaran'] as String?,
        termFrom: json['term_from'] as String?,
        termTo: json['term_to'] as String?,
        lamaHari: json['lama_hari'] as int?,
        jenisPembayaran: json['jenis_pembayaran'] as String?,
        shipment: json['shipment'] as String?,
        suplierId: json['suplier_id'] as int?,
        lokasiPengiriman: json['lokasi_pengiriman'] as String?,
        subTotal: json['sub_total'] as int?,
        tax: json['tax'] as int?,
        freightCost: json['freight_cost'] as int?,
        total: json['total'] as int?,
        dp: json['dp'] as int?,
        jmlDp: json['jml_dp'] as int?,
        catatan: json['catatan'] as String?,
        kodeProyek: json['kode_proyek'] as String?,
        preparedBy: json['prepared_by'] as int?,
        statusBsd: json['status_bsd'] as int?,
        validasiBsd: json['validasi_bsd'] as int?,
        statusDirKeuangan: json['status_dir_keuangan'] as int?,
        approvedBy: json['approved_by'] as int?,
        createdAt: json['created_at'] as int?,
        noHide: json['no_hide'] as String?,
        preparedByName: json['prepared_by_name'] as String?,
        validasiBsdName: json['validasi_bsd_name'] as String?,
        approvedByName: json['approved_by_name'] as String?,
        suplierName: json['suplier_name'] as String?,
        detail: (json['detail'] as List<dynamic>?)
            ?.map((e) => DetailPpn.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_po': noPo,
        'tgl_po': tglPo,
        'delivery_date': deliveryDate,
        'cara_pembayaran': caraPembayaran,
        'term_from': termFrom,
        'term_to': termTo,
        'lama_hari': lamaHari,
        'jenis_pembayaran': jenisPembayaran,
        'shipment': shipment,
        'suplier_id': suplierId,
        'lokasi_pengiriman': lokasiPengiriman,
        'sub_total': subTotal,
        'tax': tax,
        'freight_cost': freightCost,
        'total': total,
        'dp': dp,
        'jml_dp': jmlDp,
        'catatan': catatan,
        'kode_proyek': kodeProyek,
        'prepared_by': preparedBy,
        'status_bsd': statusBsd,
        'validasi_bsd': validasiBsd,
        'status_dir_keuangan': statusDirKeuangan,
        'approved_by': approvedBy,
        'created_at': createdAt,
        'no_hide': noHide,
        'prepared_by_name': preparedByName,
        'validasi_bsd_name': validasiBsdName,
        'approved_by_name': approvedByName,
        'suplier_name': suplierName,
        'detail': detail?.map((e) => e.toJson()).toList(),
      };

  static List<PoPpn> fromJsonList(List? data) {
    return (data ?? []).map((e) => PoPpn.fromJson(e)).toList();
  }
}
