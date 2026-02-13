class PoItem {
  final int? id;
  final String? noPo;
  final String? noBarang;
  final String? namaBarang;
  final String? qty;
  final int? satuanId;
  final String? unitPrice;
  final String? diskon;
  final String? amount;
  final int? statusAcc;
  final String? komentar;
  final int? statusAccDir;
  final String? komentarDir;
  final String? noHide;
  final int? createdAt;
  final String? kodeProyek;
  final String? tglPo;

  PoItem({
    required this.id,
    required this.noPo,
    required this.noBarang,
    required this.namaBarang,
    required this.qty,
    required this.satuanId,
    required this.unitPrice,
    required this.diskon,
    required this.amount,
    required this.statusAcc,
    required this.komentar,
    required this.statusAccDir,
    required this.komentarDir,
    required this.noHide,
    required this.createdAt,
    required this.kodeProyek,
    required this.tglPo,
  });

  factory PoItem.fromJson(Map<String, dynamic> json) {
    return PoItem(
      id: json['id'],
      noPo: json['no_po'] ?? '',
      noBarang: json['no_barang'] ?? '',
      namaBarang: json['nama_barang'] ?? '',
      qty: json['qty'] ?? '',
      satuanId: json['satuan_id'] ?? 0,
      unitPrice: json['unit_price'] ?? '',
      diskon: json['diskon'] ?? '',
      amount: json['amount'] ?? '',
      statusAcc: json['status_acc'] ?? 0,
      komentar: json['komentar'] ?? '',
      statusAccDir: json['status_acc_dir'] ?? 0,
      komentarDir: json['komentar_dir'] ?? '',
      noHide: json['no_hide'] ?? '',
      createdAt: json['created_at'] ?? 0,
      kodeProyek: json['kode_proyek'] ?? '',
      tglPo: json['tgl_po'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'no_po': noPo,
      'no_barang': noBarang,
      'nama_barang': namaBarang,
      'qty': qty,
      'satuan_id': satuanId,
      'unit_price': unitPrice,
      'diskon': diskon,
      'amount': amount,
      'status_acc': statusAcc,
      'komentar': komentar,
      'status_acc_dir': statusAccDir,
      'komentar_dir': komentarDir,
      'no_hide': noHide,
      'created_at': createdAt,
      'kode_proyek': kodeProyek,
      'tgl_po': tglPo,
    };
  }
}
