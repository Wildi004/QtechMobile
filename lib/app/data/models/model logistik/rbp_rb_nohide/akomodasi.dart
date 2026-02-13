class Akomodasi {
  int? id;
  String? kodeRbp;
  String? kodeProyek;
  String? noHideRbp;
  String? uraianAk;
  String? jumlahAk;
  int? satuanIdAk;
  String? hargaSatuanAk;
  String? totalHargaAk;
  int? createdAt;

  Akomodasi({
    this.id,
    this.kodeRbp,
    this.kodeProyek,
    this.noHideRbp,
    this.uraianAk,
    this.jumlahAk,
    this.satuanIdAk,
    this.hargaSatuanAk,
    this.totalHargaAk,
    this.createdAt,
  });

  factory Akomodasi.fromJson(Map<String, dynamic> json) => Akomodasi(
        id: json['id'] as int?,
        kodeRbp: json['kode_rbp'] as String?,
        kodeProyek: json['kode_proyek'] as String?,
        noHideRbp: json['no_hide_rbp'] as String?,
        uraianAk: json['uraian_ak'] as String?,
        jumlahAk: json['jumlah_ak'] as String?,
        satuanIdAk: json['satuan_id_ak'] as int?,
        hargaSatuanAk: json['harga_satuan_ak'] as String?,
        totalHargaAk: json['total_harga_ak'] as String?,
        createdAt: json['created_at'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_rbp': kodeRbp,
        'kode_proyek': kodeProyek,
        'no_hide_rbp': noHideRbp,
        'uraian_ak': uraianAk,
        'jumlah_ak': jumlahAk,
        'satuan_id_ak': satuanIdAk,
        'harga_satuan_ak': hargaSatuanAk,
        'total_harga_ak': totalHargaAk,
        'created_at': createdAt,
      };
}
