class SubDetailPengajuanDepBsd {
  int? id;
  String? noPengajuan;
  String? namaBarang;
  int? qty;
  int? harga;
  int? totalHarga;
  String? noHide;
  dynamic rabName;

  SubDetailPengajuanDepBsd({
    this.id,
    this.noPengajuan,
    this.namaBarang,
    this.qty,
    this.harga,
    this.totalHarga,
    this.noHide,
    this.rabName,
  });

  factory SubDetailPengajuanDepBsd.fromJson(Map<String, dynamic> json) =>
      SubDetailPengajuanDepBsd(
        id: json['id'] as int?,
        noPengajuan: json['no_pengajuan'] as String?,
        namaBarang: json['nama_barang'] as String?,
        qty: json['qty'] as int?,
        harga: json['harga'] as int?,
        totalHarga: json['total_harga'] as int?,
        noHide: json['no_hide'] as String?,
        rabName: json['rab_name'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_pengajuan': noPengajuan,
        'nama_barang': namaBarang,
        'qty': qty,
        'harga': harga,
        'total_harga': totalHarga,
        'no_hide': noHide,
        'rab_name': rabName,
      };
}
