class JenisPekerjaan {
  int? id;
  String? jenisPekerjaan;

  JenisPekerjaan({this.id, this.jenisPekerjaan});

  factory JenisPekerjaan.fromJson(Map<String, dynamic> json) => JenisPekerjaan(
        id: json['id'] as int?,
        jenisPekerjaan: json['jenis_pekerjaan'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'jenis_pekerjaan': jenisPekerjaan,
      };

  static List<JenisPekerjaan> fromJsonList(List? data) {
    return (data ?? []).map((e) => JenisPekerjaan.fromJson(e)).toList();
  }
}
