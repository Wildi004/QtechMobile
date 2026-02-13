class PoPpnProyek {
  int? id;
  String? noPo;
  int? noBarang;
  String? namaBarang;
  int? qty;
  int? satuanId;
  int? unitPrice;
  int? diskon;
  int? amount;
  int? statusAcc;
  String? komentar;
  int? statusAccDir;
  String? komentarDir;
  String? noHide;
  int? createdAt;
  String? satuanName;
  String? tglPo;
  String? suplier;

  PoPpnProyek({
    this.id,
    this.noPo,
    this.noBarang,
    this.namaBarang,
    this.qty,
    this.satuanId,
    this.unitPrice,
    this.diskon,
    this.amount,
    this.statusAcc,
    this.komentar,
    this.statusAccDir,
    this.komentarDir,
    this.noHide,
    this.createdAt,
    this.satuanName,
    this.tglPo,
    this.suplier,
  });

  factory PoPpnProyek.fromJson(Map<String, dynamic> json) => PoPpnProyek(
        id: json['id'] as int?,
        noPo: json['no_po'] as String?,
        noBarang: json['no_barang'] as int?,
        namaBarang: json['nama_barang'] as String?,
        qty: json['qty'] as int?,
        satuanId: json['satuan_id'] as int?,
        unitPrice: json['unit_price'] as int?,
        diskon: json['diskon'] as int?,
        amount: json['amount'] as int?,
        statusAcc: json['status_acc'] as int?,
        komentar: json['komentar'] as String?,
        statusAccDir: json['status_acc_dir'] as int?,
        komentarDir: json['komentar_dir'] as String?,
        noHide: json['no_hide'] as String?,
        createdAt: json['created_at'] as int?,
        satuanName: json['satuan_name'] as String?,
        tglPo: json['tgl_po'] as String?,
        suplier: json['suplier'] as String?,
      );

  Map<String, dynamic> toJson() => {
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
        'satuan_name': satuanName,
        'tgl_po': tglPo,
        'suplier': suplier,
      };

  static List<PoPpnProyek> fromJsonList(List? data) {
    return (data ?? []).map((e) => PoPpnProyek.fromJson(e)).toList();
  }
}
