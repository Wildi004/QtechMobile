class AlatUtama {
  int? id;
  String? kodeRbp;
  String? kodeProyek;
  String? noHideRbp;
  int? alatProyekId;
  String? jumlahAu;
  String? durasiAu;
  String? hargaSatuan;
  String? totalHargaAu;
  int? createdAt;
  dynamic namaAlat;

  AlatUtama({
    this.id,
    this.kodeRbp,
    this.kodeProyek,
    this.noHideRbp,
    this.alatProyekId,
    this.jumlahAu,
    this.durasiAu,
    this.hargaSatuan,
    this.totalHargaAu,
    this.createdAt,
    this.namaAlat,
  });

  factory AlatUtama.fromJson(Map<String, dynamic> json) => AlatUtama(
        id: json['id'] as int?,
        kodeRbp: json['kode_rbp'] as String?,
        kodeProyek: json['kode_proyek'] as String?,
        noHideRbp: json['no_hide_rbp'] as String?,
        alatProyekId: json['alat_proyek_id'] as int?,
        jumlahAu: json['jumlah_au'] as String?,
        durasiAu: json['durasi_au'] as String?,
        hargaSatuan: json['harga_satuan'] as String?,
        totalHargaAu: json['total_harga_au'] as String?,
        createdAt: json['created_at'] as int?,
        namaAlat: json['nama_alat'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_rbp': kodeRbp,
        'kode_proyek': kodeProyek,
        'no_hide_rbp': noHideRbp,
        'alat_proyek_id': alatProyekId,
        'jumlah_au': jumlahAu,
        'durasi_au': durasiAu,
        'harga_satuan': hargaSatuan,
        'total_harga_au': totalHargaAu,
        'created_at': createdAt,
        'nama_alat': namaAlat,
      };
}
