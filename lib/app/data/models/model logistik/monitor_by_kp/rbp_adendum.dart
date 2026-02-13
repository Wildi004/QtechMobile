class RbpAdendum {
  int? id;
  String? kodeRbp;
  String? kodeProyekAdendum;
  String? noHideRbp;
  String? uraianMuAd;
  String? jumlahMuAd;
  int? satuanIdMu;
  String? hargaModalAd;
  String? totalHargaMuAd;
  int? createdAt;
  String? kodeRbpAdendum;
  String? kodeProyek;

  // FIELD BARU
  String? kodeMaterial;
  String? hargaModalAsli;
  String? namaMaterial;
  String? jenisMaterial;
  String? jenisPekerjaan;
  String? namaPerusahaan;
  String? pembuat;
  String? ttd;
  String? satuanMaterial;

  RbpAdendum({
    this.id,
    this.kodeRbp,
    this.kodeProyekAdendum,
    this.noHideRbp,
    this.uraianMuAd,
    this.jumlahMuAd,
    this.satuanIdMu,
    this.hargaModalAd,
    this.totalHargaMuAd,
    this.createdAt,
    this.kodeRbpAdendum,
    this.kodeProyek,

    // BARU
    this.kodeMaterial,
    this.hargaModalAsli,
    this.namaMaterial,
    this.jenisMaterial,
    this.jenisPekerjaan,
    this.namaPerusahaan,
    this.pembuat,
    this.ttd,
    this.satuanMaterial,
  });

  factory RbpAdendum.fromJson(Map<String, dynamic> json) => RbpAdendum(
        id: json['id'] as int?,
        kodeRbp: json['kode_rbp'] as String?,
        kodeProyekAdendum: json['kode_proyek_adendum'] as String?,
        noHideRbp: json['no_hide_rbp'] as String?,
        uraianMuAd: json['uraian_mu_ad'] as String?,
        jumlahMuAd: json['jumlah_mu_ad'] as String?,
        satuanIdMu: json['satuan_id_mu'] as int?,
        hargaModalAd: json['harga_modal_ad'] as String?,
        totalHargaMuAd: json['total_harga_mu_ad'] as String?,
        createdAt: json['created_at'] as int?,
        kodeRbpAdendum: json['kode_rbp_adendum'] as String?,
        kodeProyek: json['kode_proyek'] as String?,

        // BARU
        kodeMaterial: json['kode_material'] as String?,
        hargaModalAsli: json['harga_modal_asli'] as String?,
        namaMaterial: json['nama_material'] as String?,
        jenisMaterial: json['jenis_material'] as String?,
        jenisPekerjaan: json['jenis_pekerjaan'] as String?,
        namaPerusahaan: json['nama_perusahaan'] as String?,
        pembuat: json['pembuat'] as String?,
        ttd: json['ttd'] as String?,
        satuanMaterial: json['satuan_material'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_rbp': kodeRbp,
        'kode_proyek_adendum': kodeProyekAdendum,
        'no_hide_rbp': noHideRbp,
        'uraian_mu_ad': uraianMuAd,
        'jumlah_mu_ad': jumlahMuAd,
        'satuan_id_mu': satuanIdMu,
        'harga_modal_ad': hargaModalAd,
        'total_harga_mu_ad': totalHargaMuAd,
        'created_at': createdAt,
        'kode_rbp_adendum': kodeRbpAdendum,
        'kode_proyek': kodeProyek,

        // BARU
        'kode_material': kodeMaterial,
        'harga_modal_asli': hargaModalAsli,
        'nama_material': namaMaterial,
        'jenis_material': jenisMaterial,
        'jenis_pekerjaan': jenisPekerjaan,
        'nama_perusahaan': namaPerusahaan,
        'pembuat': pembuat,
        'ttd': ttd,
        'satuan_material': satuanMaterial,
      };
}
