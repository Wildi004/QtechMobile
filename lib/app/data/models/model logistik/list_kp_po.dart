class ListKpPo {
  String? kodeProyek;

  ListKpPo({this.kodeProyek});

  factory ListKpPo.fromJson(Map<String, dynamic> json) => ListKpPo(
        kodeProyek: json['kode_proyek'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'kode_proyek': kodeProyek,
      };

  static List<ListKpPo> fromJsonList(List? data) {
    return (data ?? []).map((e) => ListKpPo.fromJson(e)).toList();
  }
}
