class DetailDelPoNon {
  int? id;
  String? noDelivery;
  String? kodeMaterial;
  String? kodeStr;
  String? noPo;
  String? namaBarang;
  String? qty;
  String? jumlahKeluar;
  String? beratSatuan;
  String? total;
  String? noHide;
  int? createdAt;

  DetailDelPoNon({
    this.id,
    this.noDelivery,
    this.kodeMaterial,
    this.kodeStr,
    this.noPo,
    this.namaBarang,
    this.qty,
    this.jumlahKeluar,
    this.beratSatuan,
    this.total,
    this.noHide,
    this.createdAt,
  });

  factory DetailDelPoNon.fromJson(Map<String, dynamic> json) => DetailDelPoNon(
        id: json['id'] as int?,
        noDelivery: json['no_delivery'] as String?,
        kodeMaterial: json['kode_material'] as String?,
        kodeStr: json['kode_str'] as String?,
        noPo: json['no_po'] as String?,
        namaBarang: json['nama_barang'] as String?,
        qty: json['qty'] as String?,
        jumlahKeluar: json['jumlah_keluar'] as String?,
        beratSatuan: json['berat_satuan'] as String?,
        total: json['total'] as String?,
        noHide: json['no_hide'] as String?,
        createdAt: json['created_at'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_delivery': noDelivery,
        'kode_material': kodeMaterial,
        'kode_str': kodeStr,
        'no_po': noPo,
        'nama_barang': namaBarang,
        'qty': qty,
        'jumlah_keluar': jumlahKeluar,
        'berat_satuan': beratSatuan,
        'total': total,
        'no_hide': noHide,
        'created_at': createdAt,
      };
}
