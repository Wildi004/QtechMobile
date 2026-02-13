class DetailAset {
  int? id;
  String? kodeAset;
  String? namaAset;
  int? jumlah;
  int? hargaPerolehan;
  String? tglBeli;
  int? kategoriAsetId;
  String? jenis;
  String? noPol;
  String? tglQir;
  String? tglSamsat;
  String? keterangan;
  int? status;
  String? penanggungJawab;
  String? image;
  String? qrCode;
  int? createdBy;
  int? createdAt;

  DetailAset({
    this.id,
    this.kodeAset,
    this.namaAset,
    this.jumlah,
    this.hargaPerolehan,
    this.tglBeli,
    this.kategoriAsetId,
    this.jenis,
    this.noPol,
    this.tglQir,
    this.tglSamsat,
    this.keterangan,
    this.status,
    this.penanggungJawab,
    this.image,
    this.qrCode,
    this.createdBy,
    this.createdAt,
  });

  factory DetailAset.fromJson(Map<String, dynamic> json) => DetailAset(
        id: json['id'] as int?,
        kodeAset: json['kode_aset'] as String?,
        namaAset: json['nama_aset'] as String?,
        jumlah: json['jumlah'] as int?,
        hargaPerolehan: json['harga_perolehan'] as int?,
        tglBeli: json['tgl_beli'] as String?,
        kategoriAsetId: json['kategori_aset_id'] as int?,
        jenis: json['jenis'] as String?,
        noPol: json['no_pol'] as String?,
        tglQir: json['tgl_qir'] as String?,
        tglSamsat: json['tgl_samsat'] as String?,
        keterangan: json['keterangan'] as String?,
        status: json['status'] as int?,
        penanggungJawab: json['penanggung_jawab'] as String?,
        image: json['image'] as String?,
        qrCode: json['qr_code'] as String?,
        createdBy: json['created_by'] as int?,
        createdAt: json['created_at'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_aset': kodeAset,
        'nama_aset': namaAset,
        'jumlah': jumlah,
        'harga_perolehan': hargaPerolehan,
        'tgl_beli': tglBeli,
        'kategori_aset_id': kategoriAsetId,
        'jenis': jenis,
        'no_pol': noPol,
        'tgl_qir': tglQir,
        'tgl_samsat': tglSamsat,
        'keterangan': keterangan,
        'status': status,
        'penanggung_jawab': penanggungJawab,
        'image': image,
        'qr_code': qrCode,
        'created_by': createdBy,
        'created_at': createdAt,
      };
}
