class RabDetail {
  int? id;
  String? kodeRab;
  int? kategoriRab;
  int? mingguKe;
  String? namaItem;
  String? total;
  int? overheat;
  String? subTotal;
  String? catatan;
  int? statusPengajuan;
  int? createdAt;
  String? kategoriRabName;

  RabDetail({
    this.id,
    this.kodeRab,
    this.kategoriRab,
    this.mingguKe,
    this.namaItem,
    this.total,
    this.overheat,
    this.subTotal,
    this.catatan,
    this.statusPengajuan,
    this.createdAt,
    this.kategoriRabName,
  });

  factory RabDetail.fromJson(Map<String, dynamic> json) => RabDetail(
        id: json['id'] as int?,
        kodeRab: json['kode_rab'] as String?,
        kategoriRab: json['kategori_rab'] as int?,
        mingguKe: json['minggu_ke'] as int?,
        namaItem: json['nama_item'] as String?,
        total: json['total'] as String?,
        overheat: json['overheat'] as int?,
        subTotal: json['sub_total'] as String?,
        catatan: json['catatan'] as String?,
        statusPengajuan: json['status_pengajuan'] as int?,
        createdAt: json['created_at'] as int?,
        kategoriRabName: json['kategori_rab_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_rab': kodeRab,
        'kategori_rab': kategoriRab,
        'minggu_ke': mingguKe,
        'nama_item': namaItem,
        'total': total,
        'overheat': overheat,
        'sub_total': subTotal,
        'catatan': catatan,
        'status_pengajuan': statusPengajuan,
        'created_at': createdAt,
        'kategori_rab_name': kategoriRabName,
      };
}
