class ArsipSuratMasukBsd {
  int? id;
  String? kodeSurat;
  int? status;
  String? tglSurat;
  dynamic suratKeluarPerihal;
  dynamic suratKeluarSifat;
  dynamic suratKeluarTglSurat;
  dynamic suratKeluarImage;
  dynamic suratKeluarKeterangan;
  dynamic userName;

  ArsipSuratMasukBsd({
    this.id,
    this.kodeSurat,
    this.status,
    this.tglSurat,
    this.suratKeluarPerihal,
    this.suratKeluarSifat,
    this.suratKeluarTglSurat,
    this.suratKeluarImage,
    this.suratKeluarKeterangan,
    this.userName,
  });

  factory ArsipSuratMasukBsd.fromJson(Map<String, dynamic> json) {
    return ArsipSuratMasukBsd(
      id: json['id'] as int?,
      kodeSurat: json['kode_surat'] as String?,
      status: json['status'] as int?,
      tglSurat: json['tgl_surat'] as String?,
      suratKeluarPerihal: json['surat_keluar_perihal'] as dynamic,
      suratKeluarSifat: json['surat_keluar_sifat'] as dynamic,
      suratKeluarTglSurat: json['surat_keluar_tgl_surat'] as dynamic,
      suratKeluarImage: json['surat_keluar_image'] as dynamic,
      suratKeluarKeterangan: json['surat_keluar_keterangan'] as dynamic,
      userName: json['user_name'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_surat': kodeSurat,
        'status': status,
        'tgl_surat': tglSurat,
        'surat_keluar_perihal': suratKeluarPerihal,
        'surat_keluar_sifat': suratKeluarSifat,
        'surat_keluar_tgl_surat': suratKeluarTglSurat,
        'surat_keluar_image': suratKeluarImage,
        'surat_keluar_keterangan': suratKeluarKeterangan,
        'user_name': userName,
      };

  static List<ArsipSuratMasukBsd> fromJsonList(List? data) {
    return (data ?? []).map((e) => ArsipSuratMasukBsd.fromJson(e)).toList();
  }
}
