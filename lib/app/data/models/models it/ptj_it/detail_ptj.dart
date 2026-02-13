class DetailPtjIt {
  int? id;
  String? noPtj;
  String? tglBeli;
  String? namaBarang;
  String? qty;
  String? hargaSatuan;
  String? totalHarga;
  String? image;
  int? statusAcc;
  int? statusAccDir;
  int? statusAccDirut;
  String? komentarDirut;
  String? komentar;
  String? komentarDir;
  int? createdAt;
  String? noHide;
  int? adendum;
  dynamic proyekItemName;
  String? detailPengajuanName;
  String? akunName;
  String? perkiraanName;

  DetailPtjIt({
    this.id,
    this.noPtj,
    this.tglBeli,
    this.namaBarang,
    this.qty,
    this.hargaSatuan,
    this.totalHarga,
    this.image,
    this.statusAcc,
    this.statusAccDir,
    this.statusAccDirut,
    this.komentarDirut,
    this.komentar,
    this.komentarDir,
    this.createdAt,
    this.noHide,
    this.adendum,
    this.proyekItemName,
    this.detailPengajuanName,
    this.akunName,
    this.perkiraanName,
  });

  factory DetailPtjIt.fromJson(Map<String, dynamic> json) => DetailPtjIt(
        id: json['id'] as int?,
        noPtj: json['no_ptj'] as String?,
        tglBeli: json['tgl_beli'] as String?,
        namaBarang: json['nama_barang'] as String?,
        qty: json['qty'] as String?,
        hargaSatuan: json['harga_satuan'] as String?,
        totalHarga: json['total_harga'] as String?,
        image: json['image'] as String?,
        statusAcc: json['status_acc'] as int?,
        statusAccDir: json['status_acc_dir'] as int?,
        statusAccDirut: json['status_acc_dirut'] as int?,
        komentarDirut: json['komentar_dirut'] as String?,
        komentar: json['komentar'] as String?,
        komentarDir: json['komentar_dir'] as String?,
        createdAt: json['created_at'] as int?,
        noHide: json['no_hide'] as String?,
        adendum: json['adendum'] as int?,
        proyekItemName: json['proyek_item_name'] as dynamic,
        detailPengajuanName: json['detail_pengajuan_name'] as String?,
        akunName: json['akun_name'] as String?,
        perkiraanName: json['perkiraan_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_ptj': noPtj,
        'tgl_beli': tglBeli,
        'nama_barang': namaBarang,
        'qty': qty,
        'harga_satuan': hargaSatuan,
        'total_harga': totalHarga,
        'image': image,
        'status_acc': statusAcc,
        'status_acc_dir': statusAccDir,
        'status_acc_dirut': statusAccDirut,
        'komentar_dirut': komentarDirut,
        'komentar': komentar,
        'komentar_dir': komentarDir,
        'created_at': createdAt,
        'no_hide': noHide,
        'adendum': adendum,
        'proyek_item_name': proyekItemName,
        'detail_pengajuan_name': detailPengajuanName,
        'akun_name': akunName,
        'perkiraan_name': perkiraanName,
      };
}
