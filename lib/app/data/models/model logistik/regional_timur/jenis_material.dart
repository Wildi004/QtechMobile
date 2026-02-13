class JenisMaterial {
  int? id;
  String? jenisMaterial;
  int? createdAt;
  String? jenispekerjaanName;

  JenisMaterial({
    this.id,
    this.jenisMaterial,
    this.createdAt,
    this.jenispekerjaanName,
  });

  factory JenisMaterial.fromJson(Map<String, dynamic> json) => JenisMaterial(
        id: json['id'] as int?,
        jenisMaterial: json['jenis_material'] as String?,
        createdAt: json['created_at'] as int?,
        jenispekerjaanName: json['jenispekerjaan_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'jenis_material': jenisMaterial,
        'created_at': createdAt,
        'jenispekerjaan_name': jenispekerjaanName,
      };

  static List<JenisMaterial> fromJsonList(List? data) {
    return (data ?? []).map((e) => JenisMaterial.fromJson(e)).toList();
  }
}
