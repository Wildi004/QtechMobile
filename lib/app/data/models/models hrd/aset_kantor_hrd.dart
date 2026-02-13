class AsetKantorHrd {
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
  String? statusLabel;

  int? status;
  String? penanggungJawab;
  String? image;
  String? qrCode;
  int? createdAt;
  String? userName;
  String? namaKategori;
  AsetKantorHrd({
    this.id,
    this.kodeAset,
    this.namaAset,
    this.jumlah,
    this.hargaPerolehan,
    this.tglBeli,
    this.noPol,
    this.statusLabel,
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
  });

  factory AsetKantorHrd.fromJson(Map<String, dynamic> json) => AsetKantorHrd(
        id: json['id'] is int
            ? json['id']
            : int.tryParse(json['id'].toString()),
        kodeAset: json['kode_aset'] as String?,
        namaAset: json['nama_aset'] as String?,
        jumlah: json['jumlah'] is int
            ? json['jumlah']
            : int.tryParse(json['jumlah'].toString()),
        hargaPerolehan: json['harga_perolehan'] is int
            ? json['harga_perolehan']
            : int.tryParse(json['harga_perolehan'].toString()),
        tglBeli: json['tgl_beli'] as String?,
        statusLabel: json['status_label'] as String?,
        noPol: json['no_pol'] as String?,
        tglQir: json['tgl_qir'] as String?,
        tglSamsat: json['tgl_samsat'] as String?,
        keterangan: json['keterangan'] as String?,
        status: int.tryParse(json['status'].toString()),
        penanggungJawab: json['penanggung_jawab'] as String?,
        image: json['image'] as String?,
        qrCode: json['qr_code'] as String?,
        createdAt: json['created_at'] is int
            ? json['created_at']
            : int.tryParse(json['created_at'].toString()),
        userName: json['user_name'] as String?,
        namaKategori: json['nama_kategori'] as String?,
      );

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
        'status_label': statusLabel,
        'qr_code': qrCode,
        'created_at': createdAt,
        'user_name': userName,
        'nama_kategori': namaKategori,
      };

  static List<AsetKantorHrd> fromJsonList(List? data) {
    return (data ?? []).map((e) => AsetKantorHrd.fromJson(e)).toList();
  }
}
