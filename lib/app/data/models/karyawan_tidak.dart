class KaryawanTidak {
  int? id;
  String? nik;
  String? name;
  String? noTelp;
  String? foto;
  String? regional;
  String? alamatKtp;
  String? alamatDomisili;
  String? tglLahir;
  String? tempatLahir;
  String? gender;
  String? agama;
  int? statusProyek;
  String? tglBergabung;
  int? isActive;
  int? dateCreated;
  String? role;
  String? statusKawin;
  String? proyekItem;
  String? dep;

  KaryawanTidak({
    this.id,
    this.nik,
    this.name,
    this.noTelp,
    this.foto,
    this.regional,
    this.alamatKtp,
    this.alamatDomisili,
    this.tglLahir,
    this.tempatLahir,
    this.gender,
    this.agama,
    this.statusProyek,
    this.tglBergabung,
    this.isActive,
    this.dateCreated,
    this.role,
    this.statusKawin,
    this.proyekItem,
    this.dep,
  });

  factory KaryawanTidak.fromJson(Map<String, dynamic> json) => KaryawanTidak(
        id: json['id'] as int?,
        nik: json['nik'] as String?,
        name: json['name'] as String?,
        noTelp: json['no_telp'] as String?,
        foto: json['foto'] as String?,
        regional: json['regional'] as String?,
        alamatKtp: json['alamat_ktp'] as String?,
        alamatDomisili: json['alamat_domisili'] as String?,
        tglLahir: json['tgl_lahir'] as String?,
        tempatLahir: json['tempat_lahir'] as String?,
        gender: json['gender'] as String?,
        agama: json['agama'] as String?,
        statusProyek: json['status_proyek'] as int?,
        tglBergabung: json['tgl_bergabung'] as String?,
        isActive: json['is_active'] as int?,
        dateCreated: json['date_created'] as int?,
        role: json['role'] as String?,
        statusKawin: json['status_kawin'] as String?,
        proyekItem: json['proyek_item'] as String?,
        dep: json['dep'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nik': nik,
        'name': name,
        'no_telp': noTelp,
        'foto': foto,
        'regional': regional,
        'alamat_ktp': alamatKtp,
        'alamat_domisili': alamatDomisili,
        'tgl_lahir': tglLahir,
        'tempat_lahir': tempatLahir,
        'gender': gender,
        'agama': agama,
        'status_proyek': statusProyek,
        'tgl_bergabung': tglBergabung,
        'is_active': isActive,
        'date_created': dateCreated,
        'role': role,
        'status_kawin': statusKawin,
        'proyek_item': proyekItem,
        'dep': dep,
      };

  static List<KaryawanTidak> fromJsonList(List? data) {
    return (data ?? []).map((e) => KaryawanTidak.fromJson(e)).toList();
  }
}
