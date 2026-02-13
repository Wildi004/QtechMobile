class StandarTeknik {
  int? id;
  String? judul;
  int? kategoriArsipStandarisasiTeknikId;
  String? tglUpload;
  String? keterangan;
  String? image;
  int? statusValidasi;
  int? approvedBy;
  int? createdAt;
  String? userName;
  String? namaKategori;

  StandarTeknik({
    this.id,
    this.judul,
    this.kategoriArsipStandarisasiTeknikId,
    this.tglUpload,
    this.keterangan,
    this.image,
    this.statusValidasi,
    this.approvedBy,
    this.createdAt,
    this.userName,
    this.namaKategori,
  });

  factory StandarTeknik.fromJson(Map<String, dynamic> json) => StandarTeknik(
        id: json['id'] as int?,
        judul: json['judul'] as String?,
        kategoriArsipStandarisasiTeknikId:
            json['kategori_arsip_standarisasi_teknik_id'] as int?,
        tglUpload: json['tgl_upload'] as String?,
        keterangan: json['keterangan'] as String?,
        image: json['image'] as String?,
        statusValidasi: json['status_validasi'] as int?,
        approvedBy: json['approved_by'] as int?,
        createdAt: json['created_at'] as int?,
        userName: json['user_name'] as String?,
        namaKategori: json['nama_kategori'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'judul': judul,
        'kategori_arsip_standarisasi_teknik_id':
            kategoriArsipStandarisasiTeknikId,
        'tgl_upload': tglUpload,
        'keterangan': keterangan,
        'image': image,
        'status_validasi': statusValidasi,
        'approved_by': approvedBy,
        'created_at': createdAt,
        'user_name': userName,
        'nama_kategori': namaKategori,
      };

  static List<StandarTeknik> fromJsonList(List? data) {
    return (data ?? []).map((e) => StandarTeknik.fromJson(e)).toList();
  }
}
