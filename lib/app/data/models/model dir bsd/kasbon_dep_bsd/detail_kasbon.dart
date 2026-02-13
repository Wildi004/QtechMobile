class SubDetailKasbon {
  int? id;
  String? noPengajuan;
  String? keterangan;
  int? jml;
  String? tglKasbon;
  String? tglTerima;
  int? createdAt;
  String? noHide;
  String? noHideBkk;
  String? dep;

  SubDetailKasbon({
    this.id,
    this.noPengajuan,
    this.keterangan,
    this.jml,
    this.tglKasbon,
    this.tglTerima,
    this.createdAt,
    this.noHide,
    this.noHideBkk,
    this.dep,
  });

  factory SubDetailKasbon.fromJson(Map<String, dynamic> json) =>
      SubDetailKasbon(
        id: json['id'] as int?,
        noPengajuan: json['no_pengajuan'] as String?,
        keterangan: json['keterangan'] as String?,
        jml: json['jml'] as int?,
        tglKasbon: json['tgl_kasbon'] as String?,
        tglTerima: json['tgl_terima'] as String?,
        createdAt: json['created_at'] as int?,
        noHide: json['no_hide'] as String?,
        noHideBkk: json['no_hide_bkk'] as String?,
        dep: json['dep'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_pengajuan': noPengajuan,
        'keterangan': keterangan,
        'jml': jml,
        'tgl_kasbon': tglKasbon,
        'tgl_terima': tglTerima,
        'created_at': createdAt,
        'no_hide': noHide,
        'no_hide_bkk': noHideBkk,
        'dep': dep,
      };
}
