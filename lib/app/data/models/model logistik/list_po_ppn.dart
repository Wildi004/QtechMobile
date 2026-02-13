class ListPoPpn {
  String? kodeProyek;

  ListPoPpn({this.kodeProyek});

  factory ListPoPpn.fromJson(Map<String, dynamic> json) => ListPoPpn(
        kodeProyek: json['kode_proyek'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'kode_proyek': kodeProyek,
      };

  static List<ListPoPpn> fromJsonList(List? data) {
    return (data ?? []).map((e) => ListPoPpn.fromJson(e)).toList();
  }
}
