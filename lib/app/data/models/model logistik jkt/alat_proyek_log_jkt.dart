class AlatProyekLogJkt {
  int? id;
  String? kodeAlat;
  String? type;
  String? namaAlat;
  int? jumlah;
  int? hargaSatuan;
  int? hargaPerolehan;
  int? status;
  String? keterangan;
  String? tglBeli;
  String? tglService;
  int? regId;
  int? depId;
  int? proyekItemId;
  int? pm;
  dynamic kantor;
  String? image;
  int? createdAt;
  String? qrCode;
  String? regionalName;
  String? departemenName;
  dynamic proyekName;
  String? createdByName;
  dynamic pmName;

  AlatProyekLogJkt({
    this.id,
    this.kodeAlat,
    this.type,
    this.namaAlat,
    this.jumlah,
    this.hargaSatuan,
    this.hargaPerolehan,
    this.status,
    this.keterangan,
    this.tglBeli,
    this.tglService,
    this.regId,
    this.depId,
    this.proyekItemId,
    this.pm,
    this.kantor,
    this.image,
    this.createdAt,
    this.qrCode,
    this.regionalName,
    this.departemenName,
    this.proyekName,
    this.createdByName,
    this.pmName,
  });

  factory AlatProyekLogJkt.fromJson(Map<String, dynamic> json) {
    int? toInt(dynamic v) {
      if (v == null) return null;
      if (v is int) return v;
      return int.tryParse(v.toString());
    }

    return AlatProyekLogJkt(
      id: toInt(json['id']),
      kodeAlat: json['kode_alat']?.toString(),
      type: json['type']?.toString(),
      namaAlat: json['nama_alat']?.toString(),
      jumlah: toInt(json['jumlah']),
      hargaSatuan: toInt(json['harga_satuan']),
      hargaPerolehan: toInt(json['harga_perolehan']),
      status: toInt(json['status']),
      keterangan: json['keterangan']?.toString(),
      tglBeli: json['tgl_beli']?.toString(),
      tglService: json['tgl_service']?.toString(),
      regId: toInt(json['reg_id']),
      depId: toInt(json['dep_id']),
      proyekItemId: toInt(json['proyek_item_id']),
      pm: toInt(json['pm']),
      kantor: json['kantor'],
      image: json['image']?.toString(),
      createdAt: toInt(json['created_at']),
      qrCode: json['qr_code']?.toString(),
      regionalName: json['regional_name']?.toString(),
      departemenName: json['departemen_name']?.toString(),
      proyekName: json['proyek_name'],
      createdByName: json['created_by_name']?.toString(),
      pmName: json['pm_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_alat': kodeAlat,
        'type': type,
        'nama_alat': namaAlat,
        'jumlah': jumlah,
        'harga_satuan': hargaSatuan,
        'harga_perolehan': hargaPerolehan,
        'status': status,
        'keterangan': keterangan,
        'tgl_beli': tglBeli,
        'tgl_service': tglService,
        'reg_id': regId,
        'dep_id': depId,
        'proyek_item_id': proyekItemId,
        'pm': pm,
        'kantor': kantor,
        'image': image,
        'created_at': createdAt,
        'qr_code': qrCode,
        'regional_name': regionalName,
        'departemen_name': departemenName,
        'proyek_name': proyekName,
        'created_by_name': createdByName,
        'pm_name': pmName,
      };

  static List<AlatProyekLogJkt> fromJsonList(List? data) {
    return (data ?? []).map((e) => AlatProyekLogJkt.fromJson(e)).toList();
  }
}
