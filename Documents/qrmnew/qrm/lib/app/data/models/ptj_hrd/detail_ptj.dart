class DetailPtj {
  int? id;
  String? noPtj;
  int? proyekItemId;
  String? tglBeli;
  int? detailPengajuanId;
  String? namaBarang;
  String? qty;
  String? hargaSatuan;
  String? totalHarga;
  String? image;
  int? akunId;
  int? perkiraanId;
  int? akunIdLawan;
  int? perkiraanIdLawan;
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
  dynamic detailPengajuanName;
  String? akunName;
  String? perkiraanName;

  DetailPtj({
    this.id,
    this.noPtj,
    this.proyekItemId,
    this.tglBeli,
    this.detailPengajuanId,
    this.namaBarang,
    this.qty,
    this.hargaSatuan,
    this.totalHarga,
    this.image,
    this.akunId,
    this.perkiraanId,
    this.akunIdLawan,
    this.perkiraanIdLawan,
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

  factory DetailPtj.fromJson(Map<String, dynamic> json) => DetailPtj(
        id: json['id'] as int?,
        noPtj: json['no_ptj'] as String?,
        proyekItemId: json['proyek_item_id'] as int?,
        tglBeli: json['tgl_beli'] as String?,
        detailPengajuanId: json['detail_pengajuan_id'] as int?,
        namaBarang: json['nama_barang'] as String?,
        qty: json['qty'] as String?,
        hargaSatuan: json['harga_satuan'] as String?,
        totalHarga: json['total_harga'] as String?,
        image: json['image'] as String?,
        akunId: json['akun_id'] as int?,
        perkiraanId: json['perkiraan_id'] as int?,
        akunIdLawan: json['akun_id_lawan'] as int?,
        perkiraanIdLawan: json['perkiraan_id_lawan'] as int?,
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
        detailPengajuanName: json['detail_pengajuan_name'] as dynamic,
        akunName: json['akun_name'] as String?,
        perkiraanName: json['perkiraan_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_ptj': noPtj,
        'proyek_item_id': proyekItemId,
        'tgl_beli': tglBeli,
        'detail_pengajuan_id': detailPengajuanId,
        'nama_barang': namaBarang,
        'qty': qty,
        'harga_satuan': hargaSatuan,
        'total_harga': totalHarga,
        'image': image,
        'akun_id': akunId,
        'perkiraan_id': perkiraanId,
        'akun_id_lawan': akunIdLawan,
        'perkiraan_id_lawan': perkiraanIdLawan,
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
