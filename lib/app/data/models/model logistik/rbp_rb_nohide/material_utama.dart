class MaterialUtama {
  int? id;
  String? kodeRbp;
  String? kodeProyek;
  String? noHideRbp;
  String? uraianMu;
  String? jumlahMu;
  int? satuanIdMu;
  String? hargaModal;
  String? totalHargaMu;
  int? createdAt;
  String? satuan;

  MaterialUtama({
    this.id,
    this.kodeRbp,
    this.kodeProyek,
    this.noHideRbp,
    this.uraianMu,
    this.jumlahMu,
    this.satuanIdMu,
    this.hargaModal,
    this.totalHargaMu,
    this.createdAt,
    this.satuan,
  });

  factory MaterialUtama.fromJson(Map<String, dynamic> json) => MaterialUtama(
        id: json['id'] as int?,
        kodeRbp: json['kode_rbp'] as String?,
        kodeProyek: json['kode_proyek'] as String?,
        noHideRbp: json['no_hide_rbp'] as String?,
        uraianMu: json['uraian_mu'] as String?,
        jumlahMu: json['jumlah_mu'] as String?,
        satuanIdMu: json['satuan_id_mu'] as int?,
        hargaModal: json['harga_modal'] as String?,
        totalHargaMu: json['total_harga_mu'] as String?,
        createdAt: json['created_at'] as int?,
        satuan: json['satuan'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_rbp': kodeRbp,
        'kode_proyek': kodeProyek,
        'no_hide_rbp': noHideRbp,
        'uraian_mu': uraianMu,
        'jumlah_mu': jumlahMu,
        'satuan_id_mu': satuanIdMu,
        'harga_modal': hargaModal,
        'total_harga_mu': totalHargaMu,
        'created_at': createdAt,
        'satuan': satuan,
      };
}
