class DetailSuratJalanInternal {
  int? id;
  String? kodeMaterial;
  String? kodeStr;
  String? namaBarang;
  int? volume;
  String? satuan;
  String? uraian;
  String? totalHarga;
  String? noHide;
  int? statusJurnal;
  int? createdAt;

  DetailSuratJalanInternal({
    this.id,
    this.kodeMaterial,
    this.kodeStr,
    this.namaBarang,
    this.volume,
    this.satuan,
    this.uraian,
    this.totalHarga,
    this.noHide,
    this.statusJurnal,
    this.createdAt,
  });

  factory DetailSuratJalanInternal.fromJson(Map<String, dynamic> json) =>
      DetailSuratJalanInternal(
        id: json['id'] as int?,
        kodeMaterial: json['kode_material'] as String?,
        kodeStr: json['kode_str'] as String?,
        namaBarang: json['nama_barang'] as String?,
        volume: json['volume'] as int?,
        satuan: json['satuan'] as String?,
        uraian: json['uraian'] as String?,
        totalHarga: json['total_harga'] as String?,
        noHide: json['no_hide'] as String?,
        statusJurnal: json['status_jurnal'] as int?,
        createdAt: json['created_at'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_material': kodeMaterial,
        'kode_str': kodeStr,
        'nama_barang': namaBarang,
        'volume': volume,
        'satuan': satuan,
        'uraian': uraian,
        'total_harga': totalHarga,
        'no_hide': noHide,
        'status_jurnal': statusJurnal,
        'created_at': createdAt,
      };
}
