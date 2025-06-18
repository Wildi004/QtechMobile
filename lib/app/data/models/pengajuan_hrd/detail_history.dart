class DetailHistory {
  int? id;
  String? noPengajuan;
  String? namaBarang;
  int? qty;
  int? harga;
  int? totalHarga;
  String? jenisRab;
  String? noHide;
  dynamic rabName;

  DetailHistory({
    this.id,
    this.noPengajuan,
    this.namaBarang,
    this.qty,
    this.harga,
    this.totalHarga,
    this.jenisRab,
    this.noHide,
    this.rabName,
  });

  factory DetailHistory.fromJson(Map<String, dynamic> json) => DetailHistory(
        id: json['id'] as int?,
        noPengajuan: json['no_pengajuan'] as String?,
        namaBarang: json['nama_barang'] as String?,
        qty: json['qty'] as int?,
        harga: json['harga'] as int?,
        totalHarga: json['total_harga'] as int?,
        jenisRab: json['jenis_rab'] as String?,
        noHide: json['no_hide'] as String?,
        rabName: json['rab_name'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_pengajuan': noPengajuan,
        'nama_barang': namaBarang,
        'qty': qty,
        'harga': harga,
        'total_harga': totalHarga,
        'jenis_rab': jenisRab,
        'no_hide': noHide,
        'rab_name': rabName,
      };
  static List<DetailHistory> fromJsonList(List data) {
    return data.map((e) => DetailHistory.fromJson(e)).toList();
  }
}
