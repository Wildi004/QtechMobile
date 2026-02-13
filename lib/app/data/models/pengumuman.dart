class Pengumuman {
  int? id;
  String? judul;
  String? tglUpload;
  String? tglExpired;
  String? image;
  String? userName;

  Pengumuman({
    this.id,
    this.judul,
    this.tglUpload,
    this.tglExpired,
    this.image,
    this.userName,
  });

  factory Pengumuman.fromJson(Map<String, dynamic> json) => Pengumuman(
        id: json['id'] as int?,
        judul: json['judul'] as String?,
        tglUpload: json['tgl_upload'] as String?,
        tglExpired: json['tgl_expired'] as String?,
        image: json['image'] as String?,
        userName: json['user_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'judul': judul,
        'tgl_upload': tglUpload,
        'tgl_expired': tglExpired,
        'image': image,
        'user_name': userName,
      };

  static List<Pengumuman> fromJsonList(List? data) {
    return (data ?? []).map((e) => Pengumuman.fromJson(e)).toList();
  }
}
