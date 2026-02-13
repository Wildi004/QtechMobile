class AlatProyek {
  int? id;
  String? kodeAlat;
  String? type;
  String? namaAlat;
  int? jumlah;
  String? hargaSatuan;
  String? hargaPerolehan;
  int? status;
  String? keterangan;
  String? tglBeli;
  dynamic kantor;
  String? image;
  int? createdAt;
  String? qrCode;
  String? tglService;
  String? regionalName;
  String? departemenName;
  dynamic proyekName;
  String? createdByName;
  dynamic pmName;

  int? regId;
  int? depId;
  int? proyekItemId;
  int? pm;

  AlatProyek({
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
    this.kantor,
    this.image,
    this.createdAt,
    this.qrCode,
    this.tglService,
    this.regionalName,
    this.departemenName,
    this.proyekName,
    this.createdByName,
    this.pmName,
    this.regId,
    this.depId,
    this.proyekItemId,
    this.pm,
  });

  factory AlatProyek.fromJson(Map<String, dynamic> json) => AlatProyek(
        id: int.tryParse(json['id']?.toString() ?? ''),
        kodeAlat: json['kode_alat']?.toString(),
        type: json['type']?.toString(),
        namaAlat: json['nama_alat']?.toString(),
        jumlah: int.tryParse(json['jumlah']?.toString() ?? ''),
        hargaSatuan: json['harga_satuan']?.toString(),
        hargaPerolehan: json['harga_perolehan']?.toString(),
        status: int.tryParse(json['status']?.toString() ?? ''),
        keterangan: json['keterangan']?.toString(),
        tglBeli: json['tgl_beli']?.toString(),
        kantor: json['kantor'],
        image: json['image']?.toString(),
        createdAt: int.tryParse(json['created_at']?.toString() ?? ''),
        qrCode: json['qr_code']?.toString(),
        tglService: json['tgl_service']?.toString(),
        regionalName: json['regional_name']?.toString(),
        departemenName: json['departemen_name']?.toString(),
        proyekName: json['proyek_name'],
        createdByName: json['created_by_name']?.toString(),
        pmName: json['pm_name'],
        regId: int.tryParse(json['reg_id']?.toString() ?? ''),
        depId: int.tryParse(json['dep_id']?.toString() ?? ''),
        proyekItemId: int.tryParse(json['proyek_item_id']?.toString() ?? ''),
        pm: int.tryParse(json['pm']?.toString() ?? ''),
      );

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
        'kantor': kantor,
        'image': image,
        'created_at': createdAt,
        'qr_code': qrCode,
        'tgl_service': tglService,
        'regional_name': regionalName,
        'departemen_name': departemenName,
        'proyek_name': proyekName,
        'created_by_name': createdByName,
        'pm_name': pmName,
        'reg_id': regId,
        'dep_id': depId,
        'proyek_item_id': proyekItemId,
        'pm': pm,
      };

  static List<AlatProyek> fromJsonList(List? data) {
    return (data ?? []).map((e) => AlatProyek.fromJson(e)).toList();
  }
}
