class ProyekItem {
  int? id;
  String? kodeProyek;
  String? uraianPekerjaan;
  String? volume;
  String? hargaSatuan;
  String? jmlHarga;
  String? noHide;
  DateTime? createdAt;
  String? pmName;
  dynamic semName;
  dynamic somName;
  dynamic spvName;
  String? satuan;

  ProyekItem({
    this.id,
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

  factory ProyekItem.fromJson(Map<String, dynamic> json) => ProyekItem(
        id: json['id'] as int?,
        kodeProyek: json['kode_proyek'] as String?,
        uraianPekerjaan: json['uraian_pekerjaan'] as String?,
        volume: json['volume'] as String?,
        hargaSatuan: json['harga_satuan'] as String?,
        jmlHarga: json['jml_harga'] as String?,
        noHide: json['no_hide'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        pmName: json['pm_name'] as String?,
        semName: json['sem_name'] as dynamic,
        somName: json['som_name'] as dynamic,
        spvName: json['spv_name'] as dynamic,
        satuan: json['satuan'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_proyek': kodeProyek,
        'uraian_pekerjaan': uraianPekerjaan,
        'volume': volume,
        'harga_satuan': hargaSatuan,
        'jml_harga': jmlHarga,
        'no_hide': noHide,
        'created_at': createdAt?.toIso8601String(),
        'pm_name': pmName,
        'sem_name': semName,
        'som_name': somName,
        'spv_name': spvName,
        'satuan': satuan,
      };

  static List<ProyekItem> fromJsonList(List? data) {
    return (data ?? []).map((e) => ProyekItem.fromJson(e)).toList();
  }
}
