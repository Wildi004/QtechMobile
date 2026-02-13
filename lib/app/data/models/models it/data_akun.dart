class DataAkun {
  int? id;
  String? namaAkun;
  String? website;
  String? createdByName;

  DataAkun({this.id, this.namaAkun, this.website, this.createdByName});

  factory DataAkun.fromJson(Map<String, dynamic> json) => DataAkun(
        id: json['id'] as int?,
        namaAkun: json['nama_akun'] as String?,
        website: json['website'] as String?,
        createdByName: json['created_by_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_akun': namaAkun,
        'website': website,
        'created_by_name': createdByName,
      };

  static List<DataAkun> fromJsonList(List? data) {
    return (data ?? []).map((e) => DataAkun.fromJson(e)).toList();
  }
}
