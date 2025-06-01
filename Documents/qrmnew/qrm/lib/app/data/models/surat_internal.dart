class SuratInternal {
  int? id;
  String? nama;
  String? keterangan;
  String? image;
  String? tglUpload;
  int? userId;
  String? userName;

  SuratInternal({
    this.id,
    this.nama,
    this.keterangan,
    this.image,
    this.tglUpload,
    this.userId,
    this.userName,
  });

  factory SuratInternal.fromJson(Map<String, dynamic> json) => SuratInternal(
        id: json['id'] as int?,
        nama: json['nama'] as String?,
        keterangan: json['keterangan'] as String?,
        image: json['image'] as String?,
        tglUpload: json['tgl_upload'] as String?,
        userId: json['user_id'] as int?,
        userName: json['user_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'keterangan': keterangan,
        'image': image,
        'tgl_upload': tglUpload,
        'user_id': userId,
        'user_name': userName,
      };

  static List<SuratInternal> fromJsonList(List? data) {
    return (data ?? []).map((e) => SuratInternal.fromJson(e)).toList();
  }
}
