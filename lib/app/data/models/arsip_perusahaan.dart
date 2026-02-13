class ArsipPerusahaan {
  int? id;
  String? nama;
  String? tglUpload;
  String? image;
  String? expiredDate;
  String? tglBerlakuDok;
  String? keterangan;
  int? createdAt;
  String? userName;

  ArsipPerusahaan({
    this.id,
    this.nama,
    this.tglUpload,
    this.image,
    this.expiredDate,
    this.tglBerlakuDok,
    this.keterangan,
    this.createdAt,
    this.userName,
  });

  factory ArsipPerusahaan.fromJson(Map<String, dynamic> json) {
    return ArsipPerusahaan(
      id: json['id'] as int?,
      nama: json['nama'] as String?,
      tglUpload: json['tgl_upload'] as String?,
      image: json['image'] as String?,
      expiredDate: json['expired_date'] as String?,
      tglBerlakuDok: json['tgl_berlaku_dok'] as String?,
      keterangan: json['keterangan'] as String?,
      createdAt: json['created_at'] as int?,
      userName: json['user_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'tgl_upload': tglUpload,
        'image': image,
        'expired_date': expiredDate,
        'tgl_berlaku_dok': tglBerlakuDok,
        'keterangan': keterangan,
        'created_at': createdAt,
        'user_name': userName,
      };

  static List<ArsipPerusahaan> fromJsonList(List? data) {
    return (data ?? []).map((e) => ArsipPerusahaan.fromJson(e)).toList();
  }
}
