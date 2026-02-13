import 'detail.dart';

class PoNon {
  int? id;
  String? noPoNonppn;
  String? tglPo;
  String? tglDikirim;
  String? caraPembayaran;
  String? termFrom;
  String? termTo;
  int? lamaHari;
  int? suplierId;
  int? subTotal;
  int? freightCost;
  int? total;
  int? dp;
  int? jmlDp;
  String? catatan;
  int? preparedBy;
  int? statusBsd;
  int? validasiBsd;
  int? approvedBy;
  int? statusDirKeuangan;
  int? userSession;
  int? createdAt;
  String? noHide;
  String? preparedByName;
  String? userSessionName;
  String? validasiBsdName;
  String? approvedByName;
  String? suplierName;
  List<DetailPoNon>? detail;

  PoNon({
    this.id,
    this.noPoNonppn,
    this.tglPo,
    this.tglDikirim,
    this.caraPembayaran,
    this.termFrom,
    this.termTo,
    this.lamaHari,
    this.suplierId,
    this.subTotal,
    this.freightCost,
    this.total,
    this.dp,
    this.jmlDp,
    this.catatan,
    this.preparedBy,
    this.statusBsd,
    this.validasiBsd,
    this.approvedBy,
    this.statusDirKeuangan,
    this.userSession,
    this.createdAt,
    this.noHide,
    this.preparedByName,
    this.userSessionName,
    this.validasiBsdName,
    this.approvedByName,
    this.suplierName,
    this.detail,
  });

  factory PoNon.fromJson(Map<String, dynamic> json) => PoNon(
        id: json['id'] as int?,
        noPoNonppn: json['no_po_nonppn'] as String?,
        tglPo: json['tgl_po'] as String?,
        tglDikirim: json['tgl_dikirim'] as String?,
        caraPembayaran: json['cara_pembayaran'] as String?,
        termFrom: json['term_from'] as String?,
        termTo: json['term_to'] as String?,
        lamaHari: json['lama_hari'] as int?,
        suplierId: json['suplier_id'] as int?,
        subTotal: json['sub_total'] as int?,
        freightCost: json['freight_cost'] as int?,
        total: json['total'] as int?,
        dp: json['dp'] as int?,
        jmlDp: json['jml_dp'] as int?,
        catatan: json['catatan'] as String?,
        preparedBy: json['prepared_by'] as int?,
        statusBsd: json['status_bsd'] as int?,
        validasiBsd: json['validasi_bsd'] as int?,
        approvedBy: json['approved_by'] as int?,
        statusDirKeuangan: json['status_dir_keuangan'] as int?,
        userSession: json['user_session'] as int?,
        createdAt: json['created_at'] as int?,
        noHide: json['no_hide'] as String?,
        preparedByName: json['prepared_by_name'] as String?,
        userSessionName: json['user_session_name'] as String?,
        validasiBsdName: json['validasi_bsd_name'] as String?,
        approvedByName: json['approved_by_name'] as String?,
        suplierName: json['suplier_name'] as String?,
        detail: (json['detail'] as List<dynamic>?)
            ?.map((e) => DetailPoNon.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_po_nonppn': noPoNonppn,
        'tgl_po': tglPo,
        'tgl_dikirim': tglDikirim,
        'cara_pembayaran': caraPembayaran,
        'term_from': termFrom,
        'term_to': termTo,
        'lama_hari': lamaHari,
        'suplier_id': suplierId,
        'sub_total': subTotal,
        'freight_cost': freightCost,
        'total': total,
        'dp': dp,
        'jml_dp': jmlDp,
        'catatan': catatan,
        'prepared_by': preparedBy,
        'status_bsd': statusBsd,
        'validasi_bsd': validasiBsd,
        'approved_by': approvedBy,
        'status_dir_keuangan': statusDirKeuangan,
        'user_session': userSession,
        'created_at': createdAt,
        'no_hide': noHide,
        'prepared_by_name': preparedByName,
        'user_session_name': userSessionName,
        'validasi_bsd_name': validasiBsdName,
        'approved_by_name': approvedByName,
        'suplier_name': suplierName,
        'detail': detail?.map((e) => e.toJson()).toList(),
      };

  static List<PoNon> fromJsonList(List? data) {
    return (data ?? []).map((e) => PoNon.fromJson(e)).toList();
  }
}
