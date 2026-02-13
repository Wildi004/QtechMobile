class Alat {
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
  int? regId;
  int? depId;
  int? proyekItemId;
  dynamic kantor;
  String? image;
  int? pm;
  int? createdAt;
  String? qrCode;
  String? tglService;
  String? regionalName;
  String? departemenName;
  dynamic proyekName;
  String? createdByName;
  dynamic pmName;

  Alat({
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
    this.regId,
    this.depId,
    this.proyekItemId,
    this.kantor,
    this.image,
    this.pm,
    this.createdAt,
    this.qrCode,
    this.tglService,
    this.regionalName,
    this.departemenName,
    this.proyekName,
    this.createdByName,
    this.pmName,
  });

  factory Alat.fromJson(Map<String, dynamic> json) => Alat(
        id: json['id'] as int?,
        kodeAlat: json['kode_alat'] as String?,
        type: json['type'] as String?,
        namaAlat: json['nama_alat'] as String?,
        jumlah: json['jumlah'] as int?,
        hargaSatuan: json['harga_satuan'] as String?,
        hargaPerolehan: json['harga_perolehan'] as String?,
        status: json['status'] as int?,
        keterangan: json['keterangan'] as String?,
        tglBeli: json['tgl_beli'] as String?,
        regId: json['reg_id'] as int?,
        depId: json['dep_id'] as int?,
        proyekItemId: json['proyek_item_id'] as int?,
        kantor: json['kantor'] as dynamic,
        image: json['image'] as String?,
        pm: json['pm'] as int?,
        createdAt: json['created_at'] as int?,
        qrCode: json['qr_code'] as String?,
        tglService: json['tgl_service'] as String?,
        regionalName: json['regional_name'] as String?,
        departemenName: json['departemen_name'] as String?,
        proyekName: json['proyek_name'] as dynamic,
        createdByName: json['created_by_name'] as String?,
        pmName: json['pm_name'] as dynamic,
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
        'reg_id': regId,
        'dep_id': depId,
        'proyek_item_id': proyekItemId,
        'kantor': kantor,
        'image': image,
        'pm': pm,
        'created_at': createdAt,
        'qr_code': qrCode,
        'tgl_service': tglService,
        'regional_name': regionalName,
        'departemen_name': departemenName,
        'proyek_name': proyekName,
        'created_by_name': createdByName,
        'pm_name': pmName,
      };
}
