class RabDetailValidasi {
  int? id;
  String? kodeRab;
  int? mingguKe;
  String? namaItem;
  String? total;
  int? overheat;
  String? subTotal;
  String? catatan;
  String? kategoriRabName;

  RabDetailValidasi({
    this.id,
    this.kodeRab,
    this.mingguKe,
    this.namaItem,
    this.total,
    this.overheat,
    this.subTotal,
    this.catatan,
    this.kategoriRabName,
  });

  factory RabDetailValidasi.fromJson(Map<String, dynamic> json) {
    return RabDetailValidasi(
      id: json['id'] as int?,
      kodeRab: json['kode_rab'] as String?,
      mingguKe: json['minggu_ke'] as int?,
      namaItem: json['nama_item'] as String?,
      total: json['total'] as String?,
      overheat: json['overheat'] as int?,
      subTotal: json['sub_total'] as String?,
      catatan: json['catatan'] as String?,
      kategoriRabName: json['kategori_rab_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_rab': kodeRab,
        'minggu_ke': mingguKe,
        'nama_item': namaItem,
        'total': total,
        'overheat': overheat,
        'sub_total': subTotal,
        'catatan': catatan,
        'kategori_rab_name': kategoriRabName,
      };

  static List<RabDetailValidasi> fromJsonList(List? data) {
    return (data ?? []).map((e) => RabDetailValidasi.fromJson(e)).toList();
  }
}
