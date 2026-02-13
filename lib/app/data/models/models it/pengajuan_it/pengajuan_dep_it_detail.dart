class PengajuanDepItDetail {
  int? id;
  String? noPengajuan;
  String? namaBarang;
  int? qty;
  int? harga;
  int? totalHarga;
  int? statusAcc;
  String? komentar;
  int? statusAccDir;
  String? komentarDir;
  int? statusAccDirut;
  String? komentarDirut;
  String? jenisRab;
  int? statusPtj;
  int? createdAt;
  String? noHide;
  dynamic rabName;

  PengajuanDepItDetail({
    this.id,
    this.noPengajuan,
    this.namaBarang,
    this.qty,
    this.harga,
    this.totalHarga,
    this.statusAcc,
    this.komentar,
    this.statusAccDir,
    this.komentarDir,
    this.statusAccDirut,
    this.komentarDirut,
    this.jenisRab,
    this.statusPtj,
    this.createdAt,
    this.noHide,
    this.rabName,
  });

  factory PengajuanDepItDetail.fromJson(Map<String, dynamic> json) {
    return PengajuanDepItDetail(
      id: json['id'] as int?,
      noPengajuan: json['no_pengajuan'] as String?,
      namaBarang: json['nama_barang'] as String?,
      qty: json['qty'] as int?,
      harga: json['harga'] as int?,
      totalHarga: json['total_harga'] as int?,
      statusAcc: json['status_acc'] as int?,
      komentar: json['komentar'] as String?,
      statusAccDir: json['status_acc_dir'] as int?,
      komentarDir: json['komentar_dir'] as String?,
      statusAccDirut: json['status_acc_dirut'] as int?,
      komentarDirut: json['komentar_dirut'] as String?,
      jenisRab: json['jenis_rab'] as String?,
      statusPtj: json['status_ptj'] as int?,
      createdAt: json['created_at'] as int?,
      noHide: json['no_hide'] as String?,
      rabName: json['rab_name'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_pengajuan': noPengajuan,
        'nama_barang': namaBarang,
        'qty': qty,
        'harga': harga,
        'total_harga': totalHarga,
        'status_acc': statusAcc,
        'komentar': komentar,
        'status_acc_dir': statusAccDir,
        'komentar_dir': komentarDir,
        'status_acc_dirut': statusAccDirut,
        'komentar_dirut': komentarDirut,
        'jenis_rab': jenisRab,
        'status_ptj': statusPtj,
        'created_at': createdAt,
        'no_hide': noHide,
        'rab_name': rabName,
      };

  static List<PengajuanDepItDetail> fromJsonList(List? data) {
    return (data ?? []).map((e) => PengajuanDepItDetail.fromJson(e)).toList();
  }
}
