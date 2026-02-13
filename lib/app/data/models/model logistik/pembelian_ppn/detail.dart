class DetailPembPpn {
  int? id;
  String? noPembelian;
  String? kodeMaterial;
  String? namaBarang;
  int? qty;
  int? satuanId;
  String? hargaSatuan;
  String? diskon;
  String? totalHarga;
  int? createdAt;
  String? noHide;
  String? satuanName;

  DetailPembPpn({
    this.id,
    this.noPembelian,
    this.kodeMaterial,
    this.namaBarang,
    this.qty,
    this.satuanId,
    this.hargaSatuan,
    this.diskon,
    this.totalHarga,
    this.createdAt,
    this.noHide,
    this.satuanName,
  });

  factory DetailPembPpn.fromJson(Map<String, dynamic> json) => DetailPembPpn(
        id: json['id'] as int?,
        noPembelian: json['no_pembelian'] as String?,
        kodeMaterial: json['kode_material'] as String?,
        namaBarang: json['nama_barang'] as String?,
        qty: json['qty'] as int?,
        satuanId: json['satuan_id'] as int?,
        hargaSatuan: json['harga_satuan'] as String?,
        diskon: json['diskon'] as String?,
        totalHarga: json['total_harga'] as String?,
        createdAt: json['created_at'] as int?,
        noHide: json['no_hide'] as String?,
        satuanName: json['satuan_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_pembelian': noPembelian,
        'kode_material': kodeMaterial,
        'nama_barang': namaBarang,
        'qty': qty,
        'satuan_id': satuanId,
        'harga_satuan': hargaSatuan,
        'diskon': diskon,
        'total_harga': totalHarga,
        'created_at': createdAt,
        'no_hide': noHide,
        'satuan_name': satuanName,
      };
}
