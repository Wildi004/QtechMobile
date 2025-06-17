class Detail {
  final int? id;
  final String? noPengajuan;
  final String? namaBarang;
  final int? qty;
  final int? harga;
  final int? totalHarga;
  final String? statusAcc;
  final String? komentar;
  final String? statusAccDir;
  final String? komentarDir;
  final String? statusAccDirut;
  final String? komentarDirut;
  final int? rabId;
  final String? jenisRab;
  final String? statusPtj;
  final String? createdAt;
  final String? noHide;
  final String? rabName;

  Detail({
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
    this.rabId,
    this.jenisRab,
    this.statusPtj,
    this.createdAt,
    this.noHide,
    this.rabName,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json['id'] as int?,
        noPengajuan: json['no_pengajuan']?.toString(),
        namaBarang: json['nama_barang']?.toString(),
        qty: json['qty'] is int
            ? json['qty']
            : int.tryParse(json['qty']?.toString() ?? ''),
        harga: json['harga'] is int
            ? json['harga']
            : int.tryParse(json['harga']?.toString() ?? ''),
        totalHarga: json['total_harga'] is int
            ? json['total_harga']
            : int.tryParse(json['total_harga']?.toString() ?? ''),
        statusAcc: json['status_acc']?.toString(),
        komentar: json['komentar']?.toString(),
        statusAccDir: json['status_acc_dir']?.toString(),
        komentarDir: json['komentar_dir']?.toString(),
        statusAccDirut: json['status_acc_dirut']?.toString(),
        komentarDirut: json['komentar_dirut']?.toString(),
        rabId: json['rab_id'] is int
            ? json['rab_id']
            : int.tryParse(json['rab_id']?.toString() ?? ''),
        jenisRab: json['jenis_rab']?.toString(),
        statusPtj: json['status_ptj']?.toString(),
        createdAt: json['created_at']?.toString(),
        noHide: json['no_hide']?.toString(),
        rabName: json['rab_name']?.toString(),
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
        'rab_id': rabId,
        'jenis_rab': jenisRab,
        'status_ptj': statusPtj,
        'created_at': createdAt,
        'no_hide': noHide,
        'rab_name': rabName,
      };
}
