class DetailDelpoPpn {
  int? id;
  String? noDelivery;
  String? noPo;
  String? kodeMaterial;
  String? kodeStr;
  String? namaBarang;
  String? qty;
  String? jumlahKeluar;
  String? beratSatuan;
  String? total;
  String? noHide;
  int? createdAt;

  DetailDelpoPpn({
    this.id,
    this.noDelivery,
    this.noPo,
    this.kodeMaterial,
    this.kodeStr,
    this.namaBarang,
    this.qty,
    this.jumlahKeluar,
    this.beratSatuan,
    this.total,
    this.noHide,
    this.createdAt,
  });

  factory DetailDelpoPpn.fromJson(Map<String, dynamic> json) => DetailDelpoPpn(
        id: json['id'] as int?,
        noDelivery: json['no_delivery'] as String?,
        noPo: json['no_po'] as String?,
        kodeMaterial: json['kode_material'] as String?,
        kodeStr: json['kode_str'] as String?,
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
        'no_po': noPo,
        'kode_material': kodeMaterial,
        'kode_str': kodeStr,
        'nama_barang': namaBarang,
        'qty': qty,
        'jumlah_keluar': jumlahKeluar,
        'berat_satuan': beratSatuan,
        'total': total,
        'no_hide': noHide,
        'created_at': createdAt,
      };
}
