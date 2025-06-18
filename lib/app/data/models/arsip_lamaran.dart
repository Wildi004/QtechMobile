class ArsipLamaran {
  int? id;
  String? nama;
  String? image;
  String? tglUpload;
  String? tglLamaran;
  String? posisi;
  int? userId;
  String? lokasiKantor;
  String? status;
  int? createdAt;
  String? userName;

  ArsipLamaran({
    this.id,
    this.nama,
    this.image,
    this.tglUpload,
    this.tglLamaran,
    this.posisi,
    this.userId,
    this.lokasiKantor,
    this.status,
    this.createdAt,
    this.userName,
  });

  factory ArsipLamaran.fromJson(Map<String, dynamic> json) => ArsipLamaran(
        id: json['id'] as int?,
        nama: json['nama'] as String?,
        image: json['image'] as String?,
        tglUpload: json['tgl_upload'] as String?,
        tglLamaran: json['tgl_lamaran'] as String?,
        posisi: json['posisi'] as String?,
        userId: json['user_id'] as int?,
        lokasiKantor: json['lokasi_kantor'] as String?,
        status: json['status'] as String?,
        createdAt: json['created_at'] as int?,
        userName: json['user_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'image': image,
        'tgl_upload': tglUpload,
        'tgl_lamaran': tglLamaran,
        'posisi': posisi,
        'user_id': userId,
        'lokasi_kantor': lokasiKantor,
        'status': status,
        'created_at': createdAt,
        'user_name': userName,
      };

  static List<ArsipLamaran> fromJsonList(List? data) {
    return (data ?? []).map((e) => ArsipLamaran.fromJson(e)).toList();
  }
}
