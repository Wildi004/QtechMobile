class Satuan {
  int? id;
  String? satuan;

  Satuan({this.id, this.satuan});

  factory Satuan.fromJson(Map<String, dynamic> json) => Satuan(
        id: json['id'] as int?,
        satuan: json['satuan'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'satuan': satuan,
      };
}
