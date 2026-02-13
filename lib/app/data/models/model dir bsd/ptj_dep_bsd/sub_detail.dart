class SubDetail {
  int? id;
  String? noPtj;
  String? tglBeli;
  String? namaBarang;
  String? qty;
  String? hargaSatuan;
  String? totalHarga;
  String? image;
  String? noHide;
  dynamic detailPengajuanNomor;
  dynamic detailPengajuanName;
  String? akunName;
  String? perkiraanName;
  dynamic akunLawanName;
  dynamic perkiraanLawanName;
  String? kodeProyek;
  String? judulKontrak;

  SubDetail({
    this.id,
    this.noPtj,
    this.tglBeli,
    this.namaBarang,
    this.qty,
    this.hargaSatuan,
    this.totalHarga,
    this.image,
    this.noHide,
    this.detailPengajuanNomor,
    this.detailPengajuanName,
    this.akunName,
    this.perkiraanName,
    this.akunLawanName,
    this.perkiraanLawanName,
    this.kodeProyek,
    this.judulKontrak,
  });

  factory SubDetail.fromJson(Map<String, dynamic> json) => SubDetail(
        id: json['id'] as int?,
        noPtj: json['no_ptj'] as String?,
        tglBeli: json['tgl_beli'] as String?,
        namaBarang: json['nama_barang'] as String?,
        qty: json['qty'] as String?,
        hargaSatuan: json['harga_satuan'] as String?,
        totalHarga: json['total_harga'] as String?,
        image: json['image'] as String?,
        noHide: json['no_hide'] as String?,
        detailPengajuanNomor: json['detail_pengajuan_nomor'] as dynamic,
        detailPengajuanName: json['detail_pengajuan_name'] as dynamic,
        akunName: json['akun_name'] as String?,
        perkiraanName: json['perkiraan_name'] as String?,
        akunLawanName: json['akun_lawan_name'] as dynamic,
        perkiraanLawanName: json['perkiraan_lawan_name'] as dynamic,
        kodeProyek: json['kode_proyek'] as String?,
        judulKontrak: json['judul_kontrak'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_ptj': noPtj,
        'tgl_beli': tglBeli,
        'nama_barang': namaBarang,
        'qty': qty,
        'harga_satuan': hargaSatuan,
        'total_harga': totalHarga,
        'image': image,
        'no_hide': noHide,
        'detail_pengajuan_nomor': detailPengajuanNomor,
        'detail_pengajuan_name': detailPengajuanName,
        'akun_name': akunName,
        'perkiraan_name': perkiraanName,
        'akun_lawan_name': akunLawanName,
        'perkiraan_lawan_name': perkiraanLawanName,
        'kode_proyek': kodeProyek,
        'judul_kontrak': judulKontrak,
      };
}
