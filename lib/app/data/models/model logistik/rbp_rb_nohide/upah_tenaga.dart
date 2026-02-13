class UpahTenaga {
  int? id;
  String? kodeRbp;
  String? kodeProyek;
  String? noHideRbp;
  String? uraianUpah;
  String? jumlahUpah;
  String? durasiUpah;
  String? upahNormal;
  String? totalHargaUpah;
  int? createdAt;
  dynamic jenisUpah;

  UpahTenaga({
    this.id,
    this.kodeRbp,
    this.kodeProyek,
    this.noHideRbp,
    this.uraianUpah,
    this.jumlahUpah,
    this.durasiUpah,
    this.upahNormal,
    this.totalHargaUpah,
    this.createdAt,
    this.jenisUpah,
  });

  factory UpahTenaga.fromJson(Map<String, dynamic> json) => UpahTenaga(
        id: json['id'] as int?,
        kodeRbp: json['kode_rbp'] as String?,
        kodeProyek: json['kode_proyek'] as String?,
        noHideRbp: json['no_hide_rbp'] as String?,
        uraianUpah: json['uraian_upah'] as String?,
        jumlahUpah: json['jumlah_upah'] as String?,
        durasiUpah: json['durasi_upah'] as String?,
        upahNormal: json['upah_normal'] as String?,
        totalHargaUpah: json['total_harga_upah'] as String?,
        createdAt: json['created_at'] as int?,
        jenisUpah: json['jenis_upah'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_rbp': kodeRbp,
        'kode_proyek': kodeProyek,
        'no_hide_rbp': noHideRbp,
        'uraian_upah': uraianUpah,
        'jumlah_upah': jumlahUpah,
        'durasi_upah': durasiUpah,
        'upah_normal': upahNormal,
        'total_harga_upah': totalHargaUpah,
        'created_at': createdAt,
        'jenis_upah': jenisUpah,
      };
}
