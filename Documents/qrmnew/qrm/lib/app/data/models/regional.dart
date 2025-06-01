class Regional {
  int? id;
  String? regional;

  Regional({this.id, this.regional});

  factory Regional.fromJson(Map<String, dynamic> json) => Regional(
        id: json['id'] as int?,
        regional: json['regional'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'regional': regional,
      };

  static List<Regional> fromJsonList(List? data) {
    return (data ?? []).map((e) => Regional.fromJson(e)).toList();
  }
}
