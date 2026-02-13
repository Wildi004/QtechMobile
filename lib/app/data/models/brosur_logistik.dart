class BrosurLogistik {
  int? id;
  String? nama;
  String? tglUpload;
  String? image;
  int? userId;
  String? userName;

  BrosurLogistik({
    this.id,
    this.nama,
    this.tglUpload,
    this.image,
    this.userId,
    this.userName,
  });
  factory BrosurLogistik.fromJson(Map<String, dynamic> json) {
    return BrosurLogistik(
      id: json['id'] as int?,
      nama: json['nama'] as String?,
      tglUpload: json['tgl_upload'] as String?,
      image: json['image'] as String?,
      userId: json['user_id'] as int?,
      userName: json['user_name'] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'tgl_upload': tglUpload,
        'image': image,
        'user_id': userId,
        'user_name': userName,
      };
  static List<BrosurLogistik> fromJsonList(List? data) {
    return (data ?? []).map((e) => BrosurLogistik.fromJson(e)).toList();
  }
}
