class ArsipLegal {
  int? id;
  String? nama;
  String? tglUpload;
  String? keterangan;
  String? image;
  int? createdAt;
  String? userName;

  ArsipLegal({
    this.id,
    this.nama,
    this.tglUpload,
    this.keterangan,
    this.image,
    this.createdAt,
    this.userName,
  });

  factory ArsipLegal.fromJson(Map<String, dynamic> json) => ArsipLegal(
        id: json['id'] as int?,
        nama: json['nama'] as String?,
        tglUpload: json['tgl_upload'] as String?,
        keterangan: json['keterangan'] as String?,
        image: json['image'] as String?,
        createdAt: json['created_at'] as int?,
        userName: json['user_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'tgl_upload': tglUpload,
        'keterangan': keterangan,
        'image': image,
        'created_at': createdAt,
        'user_name': userName,
      };

  static List<ArsipLegal> fromJsonList(List? data) {
    return (data ?? []).map((e) => ArsipLegal.fromJson(e)).toList();
  }
}
