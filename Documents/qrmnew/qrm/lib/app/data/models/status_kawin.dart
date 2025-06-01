class StatusKawin {
  int? id;
  String? keterangan;

  StatusKawin({this.id, this.keterangan});

  factory StatusKawin.fromJson(Map<String, dynamic> json) => StatusKawin(
        id: json['id'] as int?,
        keterangan: json['keterangan'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'keterangan': keterangan,
      };

  static List<StatusKawin> fromJsonList(List? data) {
    return (data ?? []).map((e) => StatusKawin.fromJson(e)).toList();
  }
}
