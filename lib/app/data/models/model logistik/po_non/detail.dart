class DetailPoNon {
  int? id;
  String? noPoNonppn;
  int? noBarang;
  String? namaBarang;
  int? qty;
  int? satuanId;
  int? unitPrice;
  int? diskon;
  int? amount;
  String? noHide;
  int? createdAt;
  String? satuanName;

  DetailPoNon({
    this.id,
    this.noPoNonppn,
    this.noBarang,
    this.namaBarang,
    this.qty,
    this.satuanId,
    this.unitPrice,
    this.diskon,
    this.amount,
    this.noHide,
    this.createdAt,
    this.satuanName,
  });

  factory DetailPoNon.fromJson(Map<String, dynamic> json) => DetailPoNon(
        id: json['id'] as int?,
        noPoNonppn: json['no_po_nonppn'] as String?,
        noBarang: json['no_barang'] as int?,
        namaBarang: json['nama_barang'] as String?,
        qty: json['qty'] as int?,
        satuanId: json['satuan_id'] as int?,
        unitPrice: json['unit_price'] as int?,
        diskon: json['diskon'] as int?,
        amount: json['amount'] as int?,
        noHide: json['no_hide'] as String?,
        createdAt: json['created_at'] as int?,
        satuanName: json['satuan_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_po_nonppn': noPoNonppn,
        'no_barang': noBarang,
        'nama_barang': namaBarang,
        'qty': qty,
        'satuan_id': satuanId,
        'unit_price': unitPrice,
        'diskon': diskon,
        'amount': amount,
        'no_hide': noHide,
        'created_at': createdAt,
        'satuan_name': satuanName,
      };
}
