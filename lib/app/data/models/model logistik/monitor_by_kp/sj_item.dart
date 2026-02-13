class SjItem {
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
  String? tgl;
  String? noPengajuan;
  String? tujuan;
  String? noBukti;

  SjItem({
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
    this.tgl,
    this.noPengajuan,
    this.tujuan,
    this.noBukti,
  });

  factory SjItem.fromJson(Map<String, dynamic> json) {
    return SjItem(
      id: json['id'],
      kodeMaterial: json['kode_material'],
      kodeStr: json['kode_str'],
      namaBarang: json['nama_barang'],
      volume: json['volume'],
      satuan: json['satuan'],
      uraian: json['uraian'],
      totalHarga: json['total_harga'],
      noHide: json['no_hide'],
      statusJurnal: json['status_jurnal'],
      createdAt: json['created_at'],
      tgl: json['tgl'],
      noPengajuan: json['no_pengajuan'],
      tujuan: json['tujuan'],
      noBukti: json['no_bukti'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'tgl': tgl,
      'no_pengajuan': noPengajuan,
      'tujuan': tujuan,
      'no_bukti': noBukti,
    };
  }
}
