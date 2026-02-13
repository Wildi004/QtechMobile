import 'detail.dart';

class SuratJalanExstNon {
  int? id;
  String? noBukti;
  int? vendorId;
  String? tgl;
  String? jenisSj;
  String? noPo;
  String? noKontrak;
  String? noNota;
  String? namaProyek;
  String? alamatKirim;
  String? keterangan;
  int? statusGmBali;
  int? approval;
  int? statusDir;
  int? approvedBy;
  String? bagPengiriman;
  int? penyerah;
  String? penerima;
  int? createdBy;
  String? noHide;
  int? createdAt;
  String? noPoNonppn;
  String? invNoNota;
  dynamic proyekNoKontrak;
  String? namaPerusahaan;
  String? bagLogistik;
  String? ttd;
  String? pembuat;
  List<DetailExstNon>? detail;

  SuratJalanExstNon({
    this.id,
    this.noBukti,
    this.vendorId,
    this.tgl,
    this.jenisSj,
    this.noPo,
    this.noKontrak,
    this.noNota,
    this.namaProyek,
    this.alamatKirim,
    this.keterangan,
    this.statusGmBali,
    this.approval,
    this.statusDir,
    this.approvedBy,
    this.bagPengiriman,
    this.penyerah,
    this.penerima,
    this.createdBy,
    this.noHide,
    this.createdAt,
    this.noPoNonppn,
    this.invNoNota,
    this.proyekNoKontrak,
    this.namaPerusahaan,
    this.bagLogistik,
    this.ttd,
    this.pembuat,
    this.detail,
  });

  factory SuratJalanExstNon.fromJson(Map<String, dynamic> json) {
    return SuratJalanExstNon(
      id: json['id'] as int?,
      noBukti: json['no_bukti'] as String?,
      vendorId: json['vendor_id'] as int?,
      tgl: json['tgl'] as String?,
      jenisSj: json['jenis_sj'] as String?,
      noPo: json['no_po'] as String?,
      noKontrak: json['no_kontrak'] as String?,
      noNota: json['no_nota'] as String?,
      namaProyek: json['nama_proyek'] as String?,
      alamatKirim: json['alamat_kirim'] as String?,
      keterangan: json['keterangan'] as String?,
      statusGmBali: json['status_gm_bali'] as int?,
      approval: json['approval'] as int?,
      statusDir: json['status_dir'] as int?,
      approvedBy: json['approved_by'] as int?,
      bagPengiriman: json['bag_pengiriman'] as String?,
      penyerah: json['penyerah'] as int?,
      penerima: json['penerima'] as String?,
      createdBy: json['created_by'] as int?,
      noHide: json['no_hide'] as String?,
      createdAt: json['created_at'] as int?,
      noPoNonppn: json['no_po_nonppn'] as String?,
      invNoNota: json['inv_no_nota'] as String?,
      proyekNoKontrak: json['proyek_no_kontrak'] as dynamic,
      namaPerusahaan: json['nama_perusahaan'] as String?,
      bagLogistik: json['bag_logistik'] as String?,
      ttd: json['ttd'] as String?,
      pembuat: json['pembuat'] as String?,
      detail: (json['detail'] as List<dynamic>?)
          ?.map((e) => DetailExstNon.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_bukti': noBukti,
        'vendor_id': vendorId,
        'tgl': tgl,
        'jenis_sj': jenisSj,
        'no_po': noPo,
        'no_kontrak': noKontrak,
        'no_nota': noNota,
        'nama_proyek': namaProyek,
        'alamat_kirim': alamatKirim,
        'keterangan': keterangan,
        'status_gm_bali': statusGmBali,
        'approval': approval,
        'status_dir': statusDir,
        'approved_by': approvedBy,
        'bag_pengiriman': bagPengiriman,
        'penyerah': penyerah,
        'penerima': penerima,
        'created_by': createdBy,
        'no_hide': noHide,
        'created_at': createdAt,
        'no_po_nonppn': noPoNonppn,
        'inv_no_nota': invNoNota,
        'proyek_no_kontrak': proyekNoKontrak,
        'nama_perusahaan': namaPerusahaan,
        'bag_logistik': bagLogistik,
        'ttd': ttd,
        'pembuat': pembuat,
        'detail': detail?.map((e) => e.toJson()).toList(),
      };

  static List<SuratJalanExstNon> fromJsonList(List? data) {
    return (data ?? []).map((e) => SuratJalanExstNon.fromJson(e)).toList();
  }
}
