class InvItem {
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
  String? noInvoice;
  String? tglInv;
  String? noPo;
  String? kodeProyek;

  InvItem({
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
    this.noInvoice,
    this.tglInv,
    this.noPo,
    this.kodeProyek,
  });

  factory InvItem.fromJson(Map<String, dynamic> json) {
    return InvItem(
      id: json['id'],
      noHide: json['no_hide'],
      noDelivery: json['no_delivery'],
      kodeMaterial: json['kode_material'],
      kodeStr: json['kode_str'],
      namaBarang: json['nama_barang'],
      qty: json['qty'],
      hargaSatuan: json['harga_satuan'],
      totalHarga: json['total_harga'],
      statusJurnal: json['status_jurnal'],
      noInvoice: json['no_invoice'],
      tglInv: json['tgl_inv'],
      noPo: json['no_po'],
      kodeProyek: json['kode_proyek'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'no_invoice': noInvoice,
      'tgl_inv': tglInv,
      'no_po': noPo,
      'kode_proyek': kodeProyek,
    };
  }
}
