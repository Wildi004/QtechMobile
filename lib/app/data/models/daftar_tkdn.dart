class DaftarTkdn {
  int? id;
  String? nama;
  String? resourceid;
  String? tglUpload;
  String? image;
  int? userId;
  String? userName;

  DaftarTkdn({
    this.id,
    this.nama,
    this.resourceid,
    this.tglUpload,
    this.image,
    this.userId,
    this.userName,
  });

  factory DaftarTkdn.fromJson(Map<String, dynamic> json) => DaftarTkdn(
        id: json['id'] as int?,
        nama: json['nama'] as String?,
        tglUpload: json['tgl_upload'] as String?,
        resourceid: json['resource_id'] as String?,
        image: json['image'] as String?,
        userId: json['user_id'] as int?,
        userName: json['user_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'tgl_upload': tglUpload,
        'resource_id': resourceid,
        'image': image,
        'user_id': userId,
        'user_name': userName,
      };

  static List<DaftarTkdn> fromJsonList(List? data) {
    return (data ?? []).map((e) => DaftarTkdn.fromJson(e)).toList();
  }
}
