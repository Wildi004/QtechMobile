class ArsipSuratKeluarBsd {
  int? id;
  String? kodeSurat;
  String? sifat;
  String? perihal;
  String? tglUpload;
  String? tglSurat;
  int? depId;
  String? tipe;
  int? tujuan;
  String? image;
  int? statusValidasi;
  int? validasiBy;
  String? keterangan;
  int? createdAt;
  String? userName;
  dynamic userValidatorName;
  String? departemen;

  ArsipSuratKeluarBsd({
    this.id,
    this.kodeSurat,
    this.sifat,
    this.perihal,
    this.tglUpload,
    this.tglSurat,
    this.depId,
    this.tipe,
    this.tujuan,
    this.image,
    this.statusValidasi,
    this.validasiBy,
    this.keterangan,
    this.createdAt,
    this.userName,
    this.userValidatorName,
    this.departemen,
  });

  factory ArsipSuratKeluarBsd.fromJson(Map<String, dynamic> json) {
    return ArsipSuratKeluarBsd(
      id: json['id'] as int?,
      kodeSurat: json['kode_surat'] as String?,
      sifat: json['sifat'] as String?,
      perihal: json['perihal'] as String?,
      tglUpload: json['tgl_upload'] as String?,
      tglSurat: json['tgl_surat'] as String?,
      depId: json['dep_id'] as int?,
      tipe: json['tipe'] as String?,
      tujuan: json['tujuan'] as int?,
      image: json['image'] as String?,
      statusValidasi: json['status_validasi'] as int?,
      validasiBy: json['validasi_by'] as int?,
      keterangan: json['keterangan'] as String?,
      createdAt: json['created_at'] as int?,
      userName: json['user_name'] as String?,
      userValidatorName: json['user_validator_name'] as dynamic,
      departemen: json['departemen'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_surat': kodeSurat,
        'sifat': sifat,
        'perihal': perihal,
        'tgl_upload': tglUpload,
        'tgl_surat': tglSurat,
        'dep_id': depId,
        'tipe': tipe,
        'tujuan': tujuan,
        'image': image,
        'status_validasi': statusValidasi,
        'validasi_by': validasiBy,
        'keterangan': keterangan,
        'created_at': createdAt,
        'user_name': userName,
        'user_validator_name': userValidatorName,
        'departemen': departemen,
      };

  static List<ArsipSuratKeluarBsd> fromJsonList(List? data) {
    return (data ?? []).map((e) => ArsipSuratKeluarBsd.fromJson(e)).toList();
  }
}
