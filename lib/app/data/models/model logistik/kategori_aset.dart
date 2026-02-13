class KategoriAset {
  int? id;
  String? namaKategori;
  int? createdAt;
  String? createdByName;

  KategoriAset({
    this.id,
    this.namaKategori,
    this.createdAt,
    this.createdByName,
  });

  factory KategoriAset.fromJson(Map<String, dynamic> json) => KategoriAset(
        id: json['id'] as int?,
        namaKategori: json['nama_kategori'] as String?,
        createdAt: json['created_at'] as int?,
        createdByName: json['created_by_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_kategori': namaKategori,
        'created_at': createdAt,
        'created_by_name': createdByName,
      };

  static List<KategoriAset> fromJsonList(List? data) {
    return (data ?? []).map((e) => KategoriAset.fromJson(e)).toList();
  }
}
