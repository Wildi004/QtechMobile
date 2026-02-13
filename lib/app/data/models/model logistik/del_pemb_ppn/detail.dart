class DetailDelPembPpn {
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

  DetailDelPembPpn({
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

  factory DetailDelPembPpn.fromJson(Map<String, dynamic> json) =>
      DetailDelPembPpn(
        id: json['id'] as int?,
        noPembelian: json['no_pembelian'] as String?,
        kodeMaterial: json['kode_material'] as String?,
        namaBarang: json['nama_barang'] as String?,
        qty: json['qty'] is int
            ? json['qty']
            : int.tryParse(json['qty']?.toString() ?? '0'),
        satuanId: json['satuan_id'] is int
            ? json['satuan_id']
            : int.tryParse(json['satuan_id']?.toString() ?? '0'),
        hargaSatuan: json['harga_satuan']?.toString(),
        diskon: json['diskon']?.toString(),
        totalHarga: json['total_harga']?.toString(),
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
