class DetailPengajuan {
  int? id;
  String? noPengajuan;
  String? namaBarang;
  int? qty;
  int? harga;
  int? totalHarga;
  String? jenisRab;
  String? noHide;
  String? rabName;

  DetailPengajuan({
    this.id,
    this.noPengajuan,
    this.namaBarang,
    this.qty,
    this.harga,
    this.totalHarga,
    this.jenisRab,
    this.noHide,
    this.rabName,
  });

  factory DetailPengajuan.fromJson(Map<String, dynamic> json) =>
      DetailPengajuan(
        id: json['id'] as int?,
        noPengajuan: json['no_pengajuan'] as String?,
        namaBarang: json['nama_barang'] as String?,
        qty: json['qty'] as int?,
        harga: json['harga'] as int?,
        totalHarga: json['total_harga'] as int?,
        jenisRab: json['jenis_rab'] as String?,
        noHide: json['no_hide'] as String?,
        rabName: json['rab_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_pengajuan': noPengajuan,
        'nama_barang': namaBarang,
        'qty': qty,
        'harga': harga,
        'total_harga': totalHarga,
        'jenis_rab': jenisRab,
        'no_hide': noHide,
        'rab_name': rabName,
      };
}
