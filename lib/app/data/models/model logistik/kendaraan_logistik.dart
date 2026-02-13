class KendaraanLogistik {
  int? id;
  String? kodeAset;
  String? namaAset;
  int? jumlah;
  int? hargaPerolehan;
  String? tglBeli;
  String? noPol;
  String? tglQir;
  String? tglSamsat;
  String? keterangan;
  int? status;
  String? penanggungJawab;
  String? image;
  String? qrCode;
  int? createdAt;
  String? userName;
  String? namaKategori;
  String? statusLabel;

  KendaraanLogistik({
    this.id,
    this.kodeAset,
    this.namaAset,
    this.jumlah,
    this.hargaPerolehan,
    this.tglBeli,
    this.noPol,
    this.tglQir,
    this.tglSamsat,
    this.keterangan,
    this.status,
    this.penanggungJawab,
    this.image,
    this.qrCode,
    this.createdAt,
    this.userName,
    this.namaKategori,
    this.statusLabel,
  });

  factory KendaraanLogistik.fromJson(Map<String, dynamic> json) {
    return KendaraanLogistik(
      id: json['id'] as int?,
      kodeAset: json['kode_aset'] as String?,
      namaAset: json['nama_aset'] as String?,
      jumlah: json['jumlah'] as int?,
      hargaPerolehan: json['harga_perolehan'] as int?,
      tglBeli: json['tgl_beli'] as String?,
      noPol: json['no_pol'] as String?,
      tglQir: json['tgl_qir'] as String?,
      tglSamsat: json['tgl_samsat'] as String?,
      keterangan: json['keterangan'] as String?,
      status: json['status'] as int?,
      penanggungJawab: json['penanggung_jawab'] as String?,
      image: json['image'] as String?,
      qrCode: json['qr_code'] as String?,
      createdAt: json['created_at'] as int?,
      userName: json['user_name'] as String?,
      namaKategori: json['nama_kategori'] as String?,
      statusLabel: json['status_label'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_aset': kodeAset,
        'nama_aset': namaAset,
        'jumlah': jumlah,
        'harga_perolehan': hargaPerolehan,
        'tgl_beli': tglBeli,
        'no_pol': noPol,
        'tgl_qir': tglQir,
        'tgl_samsat': tglSamsat,
        'keterangan': keterangan,
        'status': status,
        'penanggung_jawab': penanggungJawab,
        'image': image,
        'qr_code': qrCode,
        'created_at': createdAt,
        'user_name': userName,
        'nama_kategori': namaKategori,
        'status_label': statusLabel,
      };

  static List<KendaraanLogistik> fromJsonList(List? data) {
    return (data ?? []).map((e) => KendaraanLogistik.fromJson(e)).toList();
  }
}
