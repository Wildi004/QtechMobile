class LaporanItTanggal {
  int? id;
  String? namaPekerjaan;
  String? tglRencana;
  int? prioritas;
  int? status;
  String? picName;
  String? noInduk;

  LaporanItTanggal({
    this.id,
    this.namaPekerjaan,
    this.tglRencana,
    this.prioritas,
    this.status,
    this.picName,
    this.noInduk,
  });

  factory LaporanItTanggal.fromJson(Map<String, dynamic> json) {
    return LaporanItTanggal(
      id: json['id'] as int?,
      namaPekerjaan: json['nama_pekerjaan'] as String?,
      tglRencana: json['tgl_rencana'] as String?,
      prioritas: json['prioritas'] as int?,
      status: json['status'] as int?,
      picName: json['pic_name'] as String?,
      noInduk: json['no_induk'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_pekerjaan': namaPekerjaan,
        'tgl_rencana': tglRencana,
        'prioritas': prioritas,
        'status': status,
        'pic_name': picName,
        'no_induk': noInduk,
      };

  static List<LaporanItTanggal> fromJsonList(List? data) {
    return (data ?? []).map((e) => LaporanItTanggal.fromJson(e)).toList();
  }
}
