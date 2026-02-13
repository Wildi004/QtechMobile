class SatuanLogistik {
  int? id;
  String? satuan;

  SatuanLogistik({this.id, this.satuan});

  factory SatuanLogistik.fromJson(Map<String, dynamic> json) {
    return SatuanLogistik(
      id: json['id'] as int?,
      satuan: json['satuan'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'satuan': satuan,
      };

  static List<SatuanLogistik> fromJsonList(List? data) {
    return (data ?? []).map((e) => SatuanLogistik.fromJson(e)).toList();
  }
}
