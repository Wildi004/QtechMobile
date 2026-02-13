class ListInvDelpo {
  String? kodeProyek;

  ListInvDelpo({this.kodeProyek});

  factory ListInvDelpo.fromJson(Map<String, dynamic> json) => ListInvDelpo(
        kodeProyek: json['kode_proyek'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'kode_proyek': kodeProyek,
      };

  static List<ListInvDelpo> fromJsonList(List? data) {
    return (data ?? []).map((e) => ListInvDelpo.fromJson(e)).toList();
  }
}
