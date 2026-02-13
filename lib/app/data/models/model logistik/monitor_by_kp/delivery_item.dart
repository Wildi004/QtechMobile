class DeliveryItem {
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
  String? tglPo;
  String? shipmentDate;

  DeliveryItem({
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
    this.tglPo,
    this.shipmentDate,
  });

  factory DeliveryItem.fromJson(Map<String, dynamic> json) {
    return DeliveryItem(
      id: json['id'] as int?,
      noDelivery: json['no_delivery'] as String?,
      noPo: json['no_po'] as String?,
      kodeMaterial: json['kode_material'] as String?,
      kodeStr: json['kode_str'] as String?,
      namaBarang: json['nama_barang'] as String?,
      qty: json['qty']?.toString(), // bisa int/string
      jumlahKeluar: json['jumlah_keluar']?.toString(),
      beratSatuan: json['berat_satuan']?.toString(),
      total: json['total']?.toString(),
      noHide: json['no_hide'] as String?,
      createdAt: json['created_at'] as int?,
      tglPo: json['tgl_po'] as String?,
      shipmentDate: json['shipment_date'] as String?,
    );
  }

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
        'tgl_po': tglPo,
        'shipment_date': shipmentDate,
      };
}
