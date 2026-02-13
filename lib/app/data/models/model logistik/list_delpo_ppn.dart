class ListDelpoPpn {
  String? kodeProyek;

  ListDelpoPpn({this.kodeProyek});

  factory ListDelpoPpn.fromJson(Map<String, dynamic> json) => ListDelpoPpn(
        kodeProyek: json['kode_proyek'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'kode_proyek': kodeProyek,
      };

  static List<ListDelpoPpn> fromJsonList(List? data) {
    return (data ?? []).map((e) => ListDelpoPpn.fromJson(e)).toList();
  }
}
