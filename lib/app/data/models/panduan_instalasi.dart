class PanduanInstalasi {
  int? id;
  String? nama;
  String? tglUpload;
  String? link;
  String? userName;

  PanduanInstalasi({
    this.id,
    this.nama,
    this.tglUpload,
    this.link,
    this.userName,
  });

  factory PanduanInstalasi.fromJson(Map<String, dynamic> json) {
    return PanduanInstalasi(
      id: json['id'] as int?,
      nama: json['nama'] as String?,
      tglUpload: json['tgl_upload'] as String?,
      link: json['link'] as String?,
      userName: json['user_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'tgl_upload': tglUpload,
        'link': link,
        'user_name': userName,
      };

  static List<PanduanInstalasi> fromJsonList(List? data) {
    return (data ?? []).map((e) => PanduanInstalasi.fromJson(e)).toList();
  }
}
