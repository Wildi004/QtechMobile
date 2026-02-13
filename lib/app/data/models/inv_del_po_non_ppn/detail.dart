class DetailInvDelPoNonPpn {
  int? id;
  String? noHide;
  String? noDelivery;
  String? kodeMaterial;
  String? kodeStr;
  String? namaBarang;
  String? qty;
  String? hargaSatuan;
  String? totalHarga;
  int? statusJurnal;

  DetailInvDelPoNonPpn({
    this.id,
    this.noHide,
    this.noDelivery,
    this.kodeMaterial,
    this.kodeStr,
    this.namaBarang,
    this.qty,
    this.hargaSatuan,
    this.totalHarga,
    this.statusJurnal,
  });

  factory DetailInvDelPoNonPpn.fromJson(Map<String, dynamic> json) =>
      DetailInvDelPoNonPpn(
        id: json['id'] as int?,
        noHide: json['no_hide'] as String?,
        noDelivery: json['no_delivery'] as String?,
        kodeMaterial: json['kode_material'] as String?,
        kodeStr: json['kode_str'] as String?,
        namaBarang: json['nama_barang'] as String?,
        qty: json['qty'] as String?,
        hargaSatuan: json['harga_satuan'] as String?,
        totalHarga: json['total_harga'] as String?,
        statusJurnal: json['status_jurnal'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_hide': noHide,
        'no_delivery': noDelivery,
        'kode_material': kodeMaterial,
        'kode_str': kodeStr,
        'nama_barang': namaBarang,
        'qty': qty,
        'harga_satuan': hargaSatuan,
        'total_harga': totalHarga,
        'status_jurnal': statusJurnal,
      };
}
