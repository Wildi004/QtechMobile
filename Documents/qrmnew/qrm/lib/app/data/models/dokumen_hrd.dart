class DokumenHrd {
  int? id;
  String? nama;
  String? tglUpload;
  String? keterangan;
  String? image;
  int? userId;
  int? createdAt;
  String? userName;

  DokumenHrd({
    this.id,
    this.nama,
    this.tglUpload,
    this.keterangan,
    this.image,
    this.userId,
    this.createdAt,
    this.userName,
  });

  factory DokumenHrd.fromJson(Map<String, dynamic> json) => DokumenHrd(
        id: json['id'] as int?,
        nama: json['nama'] as String?,
        tglUpload: json['tgl_upload'] as String?,
        keterangan: json['keterangan'] as String?,
        image: json['image'] as String?,
        userId: json['user_id'] as int?,
        createdAt: json['created_at'] as int?,
        userName: json['user_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'tgl_upload': tglUpload,
        'keterangan': keterangan,
        'image': image,
        'user_id': userId,
        'created_at': createdAt,
        'user_name': userName,
      };

  static List<DokumenHrd> fromJsonList(List? data) {
    return (data ?? []).map((e) => DokumenHrd.fromJson(e)).toList();
  }
}
