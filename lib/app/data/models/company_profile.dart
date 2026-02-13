class CompanyProfile {
  int? id;
  String? namaPerusahaan;
  String? alamat;
  String? telpKantor;
  String? telpHp;
  String? email1;
  String? email2;
  String? fax;
  String? npwp;
  String? web;
  String? instagram;
  String? youtube;
  String? fb;
  String? telpKantorJkt;
  String? alamatJkt;
  String? telpHpJkt;
  String? email1Jkt;
  String? email2Jkt;
  String? faxJkt;
  String? npwpJkt;
  String? instagramJkt;
  String? fbJkt;
  String? youtubeJkt;
  String? bank1Jkt;
  String? rek1Jkt;
  String? bank2Jkt;
  String? rek2Jkt;
  String? bank3Jkt;
  String? rek3Jkt;
  String? strukturOrganisasi;
  String? logo;
  String? icon;
  String? bank1;
  String? rek1;
  String? bank2;
  String? rek2;
  String? bank3;
  String? rek3;
  int? updatedBy;
  int? createdAt;
  String? userUpdatedBy;

  CompanyProfile({
    this.id,
    this.namaPerusahaan,
    this.alamat,
    this.telpKantor,
    this.telpHp,
    this.email1,
    this.email2,
    this.fax,
    this.npwp,
    this.web,
    this.instagram,
    this.youtube,
    this.fb,
    this.telpKantorJkt,
    this.alamatJkt,
    this.telpHpJkt,
    this.email1Jkt,
    this.email2Jkt,
    this.faxJkt,
    this.npwpJkt,
    this.instagramJkt,
    this.fbJkt,
    this.youtubeJkt,
    this.bank1Jkt,
    this.rek1Jkt,
    this.bank2Jkt,
    this.rek2Jkt,
    this.bank3Jkt,
    this.rek3Jkt,
    this.strukturOrganisasi,
    this.logo,
    this.icon,
    this.bank1,
    this.rek1,
    this.bank2,
    this.rek2,
    this.bank3,
    this.rek3,
    this.updatedBy,
    this.createdAt,
    this.userUpdatedBy,
  });

  factory CompanyProfile.fromJson(Map<String, dynamic> json) {
    return CompanyProfile(
      id: json['id'] as int?,
      namaPerusahaan: json['nama_perusahaan'] as String?,
      alamat: json['alamat'] as String?,
      telpKantor: json['telp_kantor'] as String?,
      telpHp: json['telp_hp'] as String?,
      email1: json['email1'] as String?,
      email2: json['email2'] as String?,
      fax: json['fax'] as String?,
      npwp: json['npwp'] as String?,
      web: json['web'] as String?,
      instagram: json['instagram'] as String?,
      youtube: json['youtube'] as String?,
      fb: json['fb'] as String?,
      telpKantorJkt: json['telp_kantor_jkt'] as String?,
      alamatJkt: json['alamat_jkt'] as String?,
      telpHpJkt: json['telp_hp_jkt'] as String?,
      email1Jkt: json['email1_jkt'] as String?,
      email2Jkt: json['email2_jkt'] as String?,
      faxJkt: json['fax_jkt'] as String?,
      npwpJkt: json['npwp_jkt'] as String?,
      instagramJkt: json['instagram_jkt'] as String?,
      fbJkt: json['fb_jkt'] as String?,
      youtubeJkt: json['youtube_jkt'] as String?,
      bank1Jkt: json['bank1_jkt'] as String?,
      rek1Jkt: json['rek1_jkt'] as String?,
      bank2Jkt: json['bank2_jkt'] as String?,
      rek2Jkt: json['rek2_jkt'] as String?,
      bank3Jkt: json['bank3_jkt'] as String?,
      rek3Jkt: json['rek3_jkt'] as String?,
      strukturOrganisasi: json['struktur_organisasi'] as String?,
      logo: json['logo'] as String?,
      icon: json['icon'] as String?,
      bank1: json['bank1'] as String?,
      rek1: json['rek1'] as String?,
      bank2: json['bank2'] as String?,
      rek2: json['rek2'] as String?,
      bank3: json['bank3'] as String?,
      rek3: json['rek3'] as String?,
      updatedBy: json['updated_by'] as int?,
      createdAt: json['created_at'] as int?,
      userUpdatedBy: json['user_updated_by'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_perusahaan': namaPerusahaan,
        'alamat': alamat,
        'telp_kantor': telpKantor,
        'telp_hp': telpHp,
        'email1': email1,
        'email2': email2,
        'fax': fax,
        'npwp': npwp,
        'web': web,
        'instagram': instagram,
        'youtube': youtube,
        'fb': fb,
        'telp_kantor_jkt': telpKantorJkt,
        'alamat_jkt': alamatJkt,
        'telp_hp_jkt': telpHpJkt,
        'email1_jkt': email1Jkt,
        'email2_jkt': email2Jkt,
        'fax_jkt': faxJkt,
        'npwp_jkt': npwpJkt,
        'instagram_jkt': instagramJkt,
        'fb_jkt': fbJkt,
        'youtube_jkt': youtubeJkt,
        'bank1_jkt': bank1Jkt,
        'rek1_jkt': rek1Jkt,
        'bank2_jkt': bank2Jkt,
        'rek2_jkt': rek2Jkt,
        'bank3_jkt': bank3Jkt,
        'rek3_jkt': rek3Jkt,
        'struktur_organisasi': strukturOrganisasi,
        'logo': logo,
        'icon': icon,
        'bank1': bank1,
        'rek1': rek1,
        'bank2': bank2,
        'rek2': rek2,
        'bank3': bank3,
        'rek3': rek3,
        'updated_by': updatedBy,
        'created_at': createdAt,
        'user_updated_by': userUpdatedBy,
      };

  static List<CompanyProfile> fromJsonList(List? data) {
    return (data ?? []).map((e) => CompanyProfile.fromJson(e)).toList();
  }
}
