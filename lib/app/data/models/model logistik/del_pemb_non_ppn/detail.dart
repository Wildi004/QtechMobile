class DetailDelPembNon {
  int? id;
  String? noDelivery;
  String? noPembelian;
  String? namaBarang;
  String? qty;
  String? beratSatuan;
  String? jumlahKeluar;
  String? total;
  String? noHide;
  int? createdAt;

  DetailDelPembNon({
    this.id,
    this.noDelivery,
    this.noPembelian,
    this.namaBarang,
    this.qty,
    this.beratSatuan,
    this.jumlahKeluar,
    this.total,
    this.noHide,
    this.createdAt,
  });

  factory DetailDelPembNon.fromJson(Map<String, dynamic> json) =>
      DetailDelPembNon(
        id: json['id'] as int?,
        noDelivery: json['no_delivery'] as String?,
        noPembelian: json['no_pembelian'] as String?,
        namaBarang: json['nama_barang'] as String?,
        qty: json['qty'] as String?,
        beratSatuan: json['berat_satuan'] as String?,
        jumlahKeluar: json['jumlah_keluar'] as String?,
        total: json['total'] as String?,
        noHide: json['no_hide'] as String?,
        createdAt: json['created_at'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_delivery': noDelivery,
        'no_pembelian': noPembelian,
        'nama_barang': namaBarang,
        'qty': qty,
        'berat_satuan': beratSatuan,
        'jumlah_keluar': jumlahKeluar,
        'total': total,
        'no_hide': noHide,
        'created_at': createdAt,
      };
}
