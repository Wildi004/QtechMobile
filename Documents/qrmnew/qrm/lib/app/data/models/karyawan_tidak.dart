class KaryawanTidak {
  int? id;
  String? nik;
  String? name;
  String? noTelp;
  String? foto;
  int? roleId;
  int? depId;
  String? regional;
  String? alamatKtp;
  String? alamatDomisili;
  String? tglLahir;
  String? tempatLahir;
  String? gender;
  String? agama;
  int? statusKawinId;
  int? statusProyek;
  int? proyekItemId;
  String? tglBergabung;
  int? isActive;
  int? dateCreated;
  String? role;
  String? dept;

  KaryawanTidak({
    this.id,
    this.nik,
    this.name,
    this.noTelp,
    this.foto,
    this.roleId,
    this.depId,
    this.regional,
    this.alamatKtp,
    this.alamatDomisili,
    this.tglLahir,
    this.tempatLahir,
    this.gender,
    this.agama,
    this.statusKawinId,
    this.statusProyek,
    this.proyekItemId,
    this.tglBergabung,
    this.isActive,
    this.dateCreated,
    this.role,
    this.dept,
  });

  factory KaryawanTidak.fromJson(Map<String, dynamic> json) => KaryawanTidak(
        id: json['id'] as int?,
        nik: json['nik'] as String?,
        name: json['name'] as String?,
        noTelp: json['no_telp'] as String?,
        foto: json['foto'] as String?,
        roleId: json['role_id'] as int?,
        depId: json['dep_id'] as int?,
        regional: json['regional'] as String?,
        alamatKtp: json['alamat_ktp'] as String?,
        alamatDomisili: json['alamat_domisili'] as String?,
        tglLahir: json['tgl_lahir'] as String?,
        tempatLahir: json['tempat_lahir'] as String?,
        gender: json['gender'] as String?,
        agama: json['agama'] as String?,
        statusKawinId: json['status_kawin_id'] as int?,
        statusProyek: json['status_proyek'] as int?,
        proyekItemId: json['proyek_item_id'] as int?,
        tglBergabung: json['tgl_bergabung'] as String?,
        isActive: json['is_active'] as int?,
        dateCreated: json['date_created'] as int?,
        role: json['role'] as String?,
        dept: json['dept'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nik': nik,
        'name': name,
        'no_telp': noTelp,
        'foto': foto,
        'role_id': roleId,
        'dep_id': depId,
        'regional': regional,
        'alamat_ktp': alamatKtp,
        'alamat_domisili': alamatDomisili,
        'tgl_lahir': tglLahir,
        'tempat_lahir': tempatLahir,
        'gender': gender,
        'agama': agama,
        'status_kawin_id': statusKawinId,
        'status_proyek': statusProyek,
        'proyek_item_id': proyekItemId,
        'tgl_bergabung': tglBergabung,
        'is_active': isActive,
        'date_created': dateCreated,
        'role': role,
        'dept': dept,
      };

  static List<KaryawanTidak> fromJsonList(List? data) {
    return (data ?? []).map((e) => KaryawanTidak.fromJson(e)).toList();
  }
}
