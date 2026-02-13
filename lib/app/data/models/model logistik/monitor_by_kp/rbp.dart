class Rbp {
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

  // Tambahan field baru dari API
  String? kodeMaterial;
  String? namaMaterial;
  String? jenisMaterial;
  String? jenisPekerjaan;
  String? namaPerusahaan;
  String? pembuat;
  String? ttd;
  String? satuanMaterial;

  Rbp({
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
    this.kodeMaterial,
    this.namaMaterial,
    this.jenisMaterial,
    this.jenisPekerjaan,
    this.namaPerusahaan,
    this.pembuat,
    this.ttd,
    this.satuanMaterial,
  });

  factory Rbp.fromJson(Map<String, dynamic> json) => Rbp(
        id: _toInt(json['id']),
        kodeRbp: json['kode_rbp'] as String?,
        kodeProyek: json['kode_proyek'] as String?,
        noHideRbp: json['no_hide_rbp'] as String?,
        uraianMu: json['uraian_mu'] as String?,
        jumlahMu: json['jumlah_mu'] as String?,
        satuanIdMu: _toInt(json['satuan_id_mu']),
        hargaModal: json['harga_modal']?.toString(),
        totalHargaMu: json['total_harga_mu']?.toString(),
        createdAt: _toInt(json['created_at']),

        // Field tambahan (harus ditambahkan agar tidak hilang)
        kodeMaterial: json['kode_material']?.toString(),
        namaMaterial: json['nama_material']?.toString(),
        jenisMaterial: json['jenis_material']?.toString(),
        jenisPekerjaan: json['jenis_pekerjaan']?.toString(),
        namaPerusahaan: json['nama_perusahaan']?.toString(),
        pembuat: json['pembuat']?.toString(),
        ttd: json['ttd']?.toString(),
        satuanMaterial: json['satuan_material']?.toString(),
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

        // Tambahan field baru
        'kode_material': kodeMaterial,
        'nama_material': namaMaterial,
        'jenis_material': jenisMaterial,
        'jenis_pekerjaan': jenisPekerjaan,
        'nama_perusahaan': namaPerusahaan,
        'pembuat': pembuat,
        'ttd': ttd,
        'satuan_material': satuanMaterial,
      };

  // ===== Helper aman =====
  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString());
  }
}
