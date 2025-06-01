class DetailHistory {
  int? id;
  String? noPengajuan;
  String? namaBarang;
  int? qty;
  int? harga;
  int? totalHarga;
  int? createdAt;
  String? noHide;

  DetailHistory({
    this.id,
    this.noPengajuan,
    this.namaBarang,
    this.qty,
    this.harga,
    this.totalHarga,
    this.createdAt,
    this.noHide,
  });

  factory DetailHistory.fromJson(Map<String, dynamic> json) => DetailHistory(
        id: json['id'] as int?,
        noPengajuan: json['no_pengajuan'] as String?,
        namaBarang: json['nama_barang'] as String?,
        qty: json['qty'] as int?,
        harga: json['harga'] as int?,
        totalHarga: json['total_harga'] as int?,
        createdAt: json['created_at'] as int?,
        noHide: json['no_hide'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_pengajuan': noPengajuan,
        'nama_barang': namaBarang,
        'qty': qty,
        'harga': harga,
        'total_harga': totalHarga,
        'created_at': createdAt,
        'no_hide': noHide,
      };
  static List<DetailHistory> fromJsonList(List data) {
    return data.map((e) => DetailHistory.fromJson(e)).toList();
  }
}
