class DataProyekItem {
  int? id;
  int? pm;
  String? kodeProyek;
  String? uraianPekerjaan;
  String? volume;
  String? hargaSatuan;
  String? jmlHarga;
  String? noHide;
  int? createdAt;
  String? pmName;
  String? semName;
  String? somName;
  dynamic spvName;
  String? satuan;

  DataProyekItem({
    this.id,
    this.pm,
    this.kodeProyek,
    this.uraianPekerjaan,
    this.volume,
    this.hargaSatuan,
    this.jmlHarga,
    this.noHide,
    this.createdAt,
    this.pmName,
    this.semName,
    this.somName,
    this.spvName,
    this.satuan,
  });

  factory DataProyekItem.fromJson(Map<String, dynamic> json) {
    return DataProyekItem(
      id: json['id'] as int?,
      pm: json['pm'] as int?,
      kodeProyek: json['kode_proyek'] as String?,
      uraianPekerjaan: json['uraian_pekerjaan'] as String?,
      volume: json['volume'] as String?,
      hargaSatuan: json['harga_satuan'] as String?,
      jmlHarga: json['jml_harga'] as String?,
      noHide: json['no_hide'] as String?,
      createdAt: json['created_at'] as int?,
      pmName: json['pm_name'] as String?,
      semName: json['sem_name'] as String?,
      somName: json['som_name'] as String?,
      spvName: json['spv_name'] as dynamic,
      satuan: json['satuan'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'pm': pm,
        'kode_proyek': kodeProyek,
        'uraian_pekerjaan': uraianPekerjaan,
        'volume': volume,
        'harga_satuan': hargaSatuan,
        'jml_harga': jmlHarga,
        'no_hide': noHide,
        'created_at': createdAt,
        'pm_name': pmName,
        'sem_name': semName,
        'som_name': somName,
        'spv_name': spvName,
        'satuan': satuan,
      };
}
