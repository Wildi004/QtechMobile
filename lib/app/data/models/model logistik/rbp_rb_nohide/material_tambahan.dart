class MaterialTambahan {
  int? id;
  String? kodeRbp;
  String? kodeProyek;
  String? noHideRbp;
  String? uraianMt;
  String? jumlahMt;
  int? satuanIdMt;
  String? hargaSatuanMt;
  String? totalHargaMt;
  int? createdAt;
  String? satuan;

  MaterialTambahan({
    this.id,
    this.kodeRbp,
    this.kodeProyek,
    this.noHideRbp,
    this.uraianMt,
    this.jumlahMt,
    this.satuanIdMt,
    this.hargaSatuanMt,
    this.totalHargaMt,
    this.createdAt,
    this.satuan,
  });

  factory MaterialTambahan.fromJson(Map<String, dynamic> json) {
    return MaterialTambahan(
      id: json['id'] as int?,
      kodeRbp: json['kode_rbp'] as String?,
      kodeProyek: json['kode_proyek'] as String?,
      noHideRbp: json['no_hide_rbp'] as String?,
      uraianMt: json['uraian_mt'] as String?,
      jumlahMt: json['jumlah_mt'] as String?,
      satuanIdMt: json['satuan_id_mt'] as int?,
      hargaSatuanMt: json['harga_satuan_mt'] as String?,
      totalHargaMt: json['total_harga_mt'] as String?,
      createdAt: json['created_at'] as int?,
      satuan: json['satuan'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_rbp': kodeRbp,
        'kode_proyek': kodeProyek,
        'no_hide_rbp': noHideRbp,
        'uraian_mt': uraianMt,
        'jumlah_mt': jumlahMt,
        'satuan_id_mt': satuanIdMt,
        'harga_satuan_mt': hargaSatuanMt,
        'total_harga_mt': totalHargaMt,
        'created_at': createdAt,
        'satuan': satuan,
      };
}
