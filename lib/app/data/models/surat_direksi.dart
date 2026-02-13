class SuratDireksi {
  int? id;
  String? noSk;
  String? nama;
  String? tglSk;
  String? image;
  int? userId;
  int? createdAt;
  String? userName;

  SuratDireksi({
    this.id,
    this.noSk,
    this.nama,
    this.tglSk,
    this.image,
    this.userId,
    this.createdAt,
    this.userName,
  });

  factory SuratDireksi.fromJson(Map<String, dynamic> json) => SuratDireksi(
        id: json['id'] as int?,
        noSk: json['no_sk'] as String?,
        nama: json['nama'] as String?,
        tglSk: json['tgl_sk'] as String?,
        image: json['image'] as String?,
        userId: json['user_id'] as int?,
        createdAt: json['created_at'] as int?,
        userName: json['user_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_sk': noSk,
        'nama': nama,
        'tgl_sk': tglSk,
        'image': image,
        'user_id': userId,
        'created_at': createdAt,
        'user_name': userName,
      };

  static List<SuratDireksi> fromJsonList(List? data) {
    return (data ?? []).map((e) => SuratDireksi.fromJson(e)).toList();
  }
}
