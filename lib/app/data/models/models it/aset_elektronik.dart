class AsetElektronik {
  int? id;
  String? namaAsset;
  String? kodeAsset;
  String? kondisi;
  String? merk;
  String? keterangan;
  String? tglBeli;
  String? tglPemberian;
  String? image;
  String? image2;
  String? qrCode;
  int? harga;
  String? noHide;
  int? createdAt;
  String? penanggungJawabName;
  String? createdByName;

  AsetElektronik({
    this.id,
    this.namaAsset,
    this.kodeAsset,
    this.kondisi,
    this.merk,
    this.keterangan,
    this.tglBeli,
    this.tglPemberian,
    this.image,
    this.image2,
    this.qrCode,
    this.harga,
    this.noHide,
    this.createdAt,
    this.penanggungJawabName,
    this.createdByName,
  });

  factory AsetElektronik.fromJson(Map<String, dynamic> json) {
    return AsetElektronik(
      id: json['id'] as int?,
      namaAsset: json['nama_asset'] as String?,
      kodeAsset: json['kode_asset'] as String?,
      kondisi: json['kondisi'] as String?,
      merk: json['merk'] as String?,
      keterangan: json['keterangan'] as String?,
      tglBeli: json['tgl_beli'] as String?,
      tglPemberian: json['tgl_pemberian'] as String?,
      image: json['image'] as String?,
      image2: json['image2'] as String?,
      qrCode: json['qr_code'] as String?,
      harga: json['harga'] as int?,
      noHide: json['no_hide'] as String?,
      createdAt: json['created_at'] as int?,
      penanggungJawabName: json['penanggung_jawab_name'] as String?,
      createdByName: json['created_by_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_asset': namaAsset,
        'kode_asset': kodeAsset,
        'kondisi': kondisi,
        'merk': merk,
        'keterangan': keterangan,
        'tgl_beli': tglBeli,
        'tgl_pemberian': tglPemberian,
        'image': image,
        'image2': image2,
        'qr_code': qrCode,
        'harga': harga,
        'no_hide': noHide,
        'created_at': createdAt,
        'penanggung_jawab_name': penanggungJawabName,
        'created_by_name': createdByName,
      };

  static List<AsetElektronik> fromJsonList(List? data) {
    return (data ?? []).map((e) => AsetElektronik.fromJson(e)).toList();
  }
}
