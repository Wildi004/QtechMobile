class NamaMaterial {
  int? id;
  String? namaMaterial;
  int? createdAt;
  String? jenismaterialName;

  NamaMaterial({
    this.id,
    this.namaMaterial,
    this.createdAt,
    this.jenismaterialName,
  });

  factory NamaMaterial.fromJson(Map<String, dynamic> json) => NamaMaterial(
        id: json['id'] as int?,
        namaMaterial: json['nama_material'] as String?,
        createdAt: json['created_at'] as int?,
        jenismaterialName: json['jenismaterial_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_material': namaMaterial,
        'created_at': createdAt,
        'jenismaterial_name': jenismaterialName,
      };

  static List<NamaMaterial> fromJsonList(List? data) {
    return (data ?? []).map((e) => NamaMaterial.fromJson(e)).toList();
  }
}
