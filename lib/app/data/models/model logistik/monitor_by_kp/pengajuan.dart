class Pengajuan {
  int? id;
  String? noPengajuan;
  String? namaBarang;
  String? qty;
  String? harga;
  String? totalHarga;
  int? statusAcc;
  String? komentar;
  int? statusAccDir;
  String? komentarDir;
  int? statusAccDirut;
  String? komentarDirut;
  String? noHide;
  int? createdAt;
  String? tglPengajuan;

  Pengajuan({
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
    this.noHide,
    this.createdAt,
    this.tglPengajuan,
  });

  factory Pengajuan.fromJson(Map<String, dynamic> json) => Pengajuan(
        id: json['id'] as int?,
        noPengajuan: toStr(json['no_pengajuan']),
        namaBarang: toStr(json['nama_barang']),
        qty: toStr(json['qty']),
        harga: toStr(json['harga']),
        totalHarga: toStr(json['total_harga']),
        statusAcc: json['status_acc'] as int?,
        komentar: toStr(json['komentar']),
        statusAccDir: json['status_acc_dir'] as int?,
        komentarDir: toStr(json['komentar_dir']),
        statusAccDirut: json['status_acc_dirut'] as int?,
        komentarDirut: toStr(json['komentar_dirut']),
        noHide: toStr(json['no_hide']),
        createdAt: json['created_at'] as int?,
        tglPengajuan: toStr(json['tgl_pengajuan']),
      );

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
        'no_hide': noHide,
        'created_at': createdAt,
        'tgl_pengajuan': tglPengajuan,
      };
}

String? toStr(dynamic value) {
  if (value == null) return null;
  return value.toString();
}
