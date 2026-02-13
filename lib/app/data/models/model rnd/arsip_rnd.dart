class ArsipRnd {
  int? id;
  String? nama;
  String? tglUpload;
  String? keterangan;
  String? image;
  int? createdAt;
  String? userName;

  ArsipRnd({
    this.id,
    this.nama,
    this.tglUpload,
    this.keterangan,
    this.image,
    this.createdAt,
    this.userName,
  });

  factory ArsipRnd.fromJson(Map<String, dynamic> json) => ArsipRnd(
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

  static List<ArsipRnd> fromJsonList(List? data) {
    return (data ?? []).map((e) => ArsipRnd.fromJson(e)).toList();
  }
}
