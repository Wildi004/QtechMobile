class DataKontrak {
  int? id;
  String? nama;
  String? kodeKontrak;
  int? inOut;
  int? statusKontrak;
  String? tglDistribusi;
  int? requestBy;
  String? tglKontrak;
  String? tglSelesai;
  int? lamaHari;
  String? nilaiKontrak;
  String? image;
  String? image1;
  String? image2;
  String? keterangan;
  int? createdAt;
  String? userName;
  String? requestByName;

  DataKontrak({
    this.id,
    this.nama,
    this.kodeKontrak,
    this.inOut,
    this.statusKontrak,
    this.tglDistribusi,
    this.requestBy,
    this.tglKontrak,
    this.tglSelesai,
    this.lamaHari,
    this.nilaiKontrak,
    this.image,
    this.image1,
    this.image2,
    this.keterangan,
    this.createdAt,
    this.userName,
    this.requestByName,
  });

  factory DataKontrak.fromJson(Map<String, dynamic> json) => DataKontrak(
        id: json['id'] as int?,
        nama: json['nama'] as String?,
        kodeKontrak: json['kode_kontrak'] as String?,
        inOut: json['in_out'] as int?,
        statusKontrak: json['status_kontrak'] as int?,
        tglDistribusi: json['tgl_distribusi'] as String?,
        requestBy: json['request_by'] as int?,
        tglKontrak: json['tgl_kontrak'] as String?,
        tglSelesai: json['tgl_selesai'] as String?,
        lamaHari: json['lama_hari'] as int?,
        nilaiKontrak: json['nilai_kontrak'] as String?,
        image: json['image'] as String?,
        image1: json['image1'] as String?,
        image2: json['image2'] as String?,
        keterangan: json['keterangan'] as String?,
        createdAt: json['created_at'] as int?,
        userName: json['user_name'] as String?,
        requestByName: json['request_by_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'kode_kontrak': kodeKontrak,
        'in_out': inOut,
        'status_kontrak': statusKontrak,
        'tgl_distribusi': tglDistribusi,
        'request_by': requestBy,
        'tgl_kontrak': tglKontrak,
        'tgl_selesai': tglSelesai,
        'lama_hari': lamaHari,
        'nilai_kontrak': nilaiKontrak,
        'image': image,
        'image1': image1,
        'image2': image2,
        'keterangan': keterangan,
        'created_at': createdAt,
        'user_name': userName,
        'request_by_name': requestByName,
      };

  static List<DataKontrak> fromJsonList(List? data) {
    return (data ?? []).map((e) => DataKontrak.fromJson(e)).toList();
  }
}
