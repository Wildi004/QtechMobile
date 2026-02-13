class SuratEksternal {
  int? id;
  String? noSurat;
  String? tgl;
  String? keperluan;
  int? createdBy;
  int? createdAt;
  String? userName;

  SuratEksternal({
    this.id,
    this.noSurat,
    this.tgl,
    this.keperluan,
    this.createdBy,
    this.createdAt,
    this.userName,
  });

  factory SuratEksternal.fromJson(Map<String, dynamic> json) {
    return SuratEksternal(
      id: json['id'] as int?,
      noSurat: json['no_surat'] as String?,
      tgl: json['tgl'] as String?,
      keperluan: json['keperluan'] as String?,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] as int?,
      userName: json['user_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_surat': noSurat,
        'tgl': tgl,
        'keperluan': keperluan,
        'created_by': createdBy,
        'created_at': createdAt,
        'user_name': userName,
      };

  static List<SuratEksternal> fromJsonList(List? data) {
    return (data ?? []).map((e) => SuratEksternal.fromJson(e)).toList();
  }
}
