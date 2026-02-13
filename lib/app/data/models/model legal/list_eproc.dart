class ListEproc {
  int? id;
  String? namaEproc;
  String? website;
  String? createdByName;

  ListEproc({this.id, this.namaEproc, this.website, this.createdByName});

  factory ListEproc.fromJson(Map<String, dynamic> json) => ListEproc(
        id: json['id'] as int?,
        namaEproc: json['nama_eproc'] as String?,
        website: json['website'] as String?,
        createdByName: json['created_by_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_eproc': namaEproc,
        'website': website,
        'created_by_name': createdByName,
      };

  static List<ListEproc> fromJsonList(List? data) {
    return (data ?? []).map((e) => ListEproc.fromJson(e)).toList();
  }
}
