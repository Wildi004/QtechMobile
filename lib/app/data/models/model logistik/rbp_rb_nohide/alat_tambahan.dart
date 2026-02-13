class AlatTambahan {
  int? id;
  String? kodeRbp;
  String? kodeProyek;
  String? noHideRbp;
  String? uraianAt;
  String? jumlahAt;
  int? satuanIdAt;
  String? hargaSatuanAt;
  String? totalHargaAt;
  int? createdAt;

  AlatTambahan({
    this.id,
    this.kodeRbp,
    this.kodeProyek,
    this.noHideRbp,
    this.uraianAt,
    this.jumlahAt,
    this.satuanIdAt,
    this.hargaSatuanAt,
    this.totalHargaAt,
    this.createdAt,
  });

  factory AlatTambahan.fromJson(Map<String, dynamic> json) => AlatTambahan(
        id: json['id'] as int?,
        kodeRbp: json['kode_rbp'] as String?,
        kodeProyek: json['kode_proyek'] as String?,
        noHideRbp: json['no_hide_rbp'] as String?,
        uraianAt: json['uraian_at'] as String?,
        jumlahAt: json['jumlah_at'] as String?,
        satuanIdAt: json['satuan_id_at'] as int?,
        hargaSatuanAt: json['harga_satuan_at'] as String?,
        totalHargaAt: json['total_harga_at'] as String?,
        createdAt: json['created_at'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_rbp': kodeRbp,
        'kode_proyek': kodeProyek,
        'no_hide_rbp': noHideRbp,
        'uraian_at': uraianAt,
        'jumlah_at': jumlahAt,
        'satuan_id_at': satuanIdAt,
        'harga_satuan_at': hargaSatuanAt,
        'total_harga_at': totalHargaAt,
        'created_at': createdAt,
      };
}
