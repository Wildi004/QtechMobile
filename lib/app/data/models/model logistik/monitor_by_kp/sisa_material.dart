class SisaMaterial {
  String? kodeProyek;
  String? tglInput;
  String? lokasiGudang;
  int? sisa;
  String? kondisi;
  String? tglExpired;
  String? kodeMaterial;
  String? brand;
  String? hargaModal;
  int? stokAwal;
  String? totalHarga;
  String? name;

  SisaMaterial({
    this.kodeProyek,
    this.tglInput,
    this.lokasiGudang,
    this.sisa,
    this.kondisi,
    this.tglExpired,
    this.kodeMaterial,
    this.brand,
    this.hargaModal,
    this.stokAwal,
    this.totalHarga,
    this.name,
  });

  factory SisaMaterial.fromJson(Map<String, dynamic> json) {
    return SisaMaterial(
      kodeProyek: json['kode_proyek'],
      tglInput: json['tgl_input'],
      lokasiGudang: json['lokasi_gudang'],
      sisa: json['sisa'],
      kondisi: json['kondisi'],
      tglExpired: json['tgl_expired'],
      kodeMaterial: json['kode_material'],
      brand: json['brand'],
      hargaModal: json['harga_modal'],
      stokAwal: json['stok_awal'],
      totalHarga: json['total_harga'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kode_proyek': kodeProyek,
      'tgl_input': tglInput,
      'lokasi_gudang': lokasiGudang,
      'sisa': sisa,
      'kondisi': kondisi,
      'tgl_expired': tglExpired,
      'kode_material': kodeMaterial,
      'brand': brand,
      'harga_modal': hargaModal,
      'stok_awal': stokAwal,
      'total_harga': totalHarga,
      'name': name,
    };
  }
}
