class KategoriRab {
  int? id;
  String? kategori;
  int? createdAt;

  KategoriRab({this.id, this.kategori, this.createdAt});

  factory KategoriRab.fromJson(Map<String, dynamic> json) => KategoriRab(
        id: json['id'] as int?,
        kategori: json['kategori'] as String?,
        createdAt: json['created_at'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kategori': kategori,
        'created_at': createdAt,
      };

  static List<KategoriRab> fromJsonList(List? data) {
    return (data ?? []).map((e) => KategoriRab.fromJson(e)).toList();
  }
}
