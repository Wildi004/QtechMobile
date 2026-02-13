class Detail {
  int? id;
  String? kode;
  String? files;

  Detail({this.id, this.kode, this.files});

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json['id'] as int?,
        kode: json['kode'] as String?,
        files: json['files'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode': kode,
        'files': files,
      };
}
