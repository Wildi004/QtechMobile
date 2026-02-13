class DetailExst {
  int? id;
  String? kodeMaterial;
  String? kodeStr;
  String? namaBarang;
  int? volume;
  String? satuan;
  String? uraian;
  String? noHide;
  int? createdAt;
  int? statusJurnal;

  DetailExst({
    this.id,
    this.kodeMaterial,
    this.kodeStr,
    this.namaBarang,
    this.volume,
    this.satuan,
    this.uraian,
    this.noHide,
    this.createdAt,
    this.statusJurnal,
  });

  factory DetailExst.fromJson(Map<String, dynamic> json) => DetailExst(
        id: json['id'] as int?,
        kodeMaterial: json['kode_material'] as String?,
        kodeStr: json['kode_str'] as String?,
        namaBarang: json['nama_barang'] as String?,
        volume: json['volume'] as int?,
        satuan: json['satuan'] as String?,
        uraian: json['uraian'] as String?,
        noHide: json['no_hide'] as String?,
        createdAt: json['created_at'] as int?,
        statusJurnal: json['status_jurnal'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_material': kodeMaterial,
        'kode_str': kodeStr,
        'nama_barang': namaBarang,
        'volume': volume,
        'satuan': satuan,
        'uraian': uraian,
        'no_hide': noHide,
        'created_at': createdAt,
        'status_jurnal': statusJurnal,
      };
}
