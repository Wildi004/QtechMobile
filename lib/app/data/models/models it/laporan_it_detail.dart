class LaporanItDetail {
  int? id;
  String? namaPekerjaan;
  String? periode;
  String? minggu;
  String? tglRencana;
  String? tglPenyelesaian;
  int? statusValidasi;
  int? validasiBy;
  int? prioritas;
  int? status;
  String? keterangan;
  String? image;
  String? output;
  int? penilaian;
  int? createdAt;
  String? userName;
  String? depName;
  dynamic kategoriRkName;
  dynamic validasiByName;
  String? picName;
  dynamic requestByName;

  LaporanItDetail({
    this.id,
    this.namaPekerjaan,
    this.periode,
    this.minggu,
    this.tglRencana,
    this.tglPenyelesaian,
    this.statusValidasi,
    this.validasiBy,
    this.prioritas,
    this.status,
    this.keterangan,
    this.image,
    this.output,
    this.penilaian,
    this.createdAt,
    this.userName,
    this.depName,
    this.kategoriRkName,
    this.validasiByName,
    this.picName,
    this.requestByName,
  });

  factory LaporanItDetail.fromJson(Map<String, dynamic> json) {
    return LaporanItDetail(
      id: json['id'] as int?,
      namaPekerjaan: json['nama_pekerjaan'] as String?,
      periode: json['periode'] as String?,
      minggu: json['minggu'] as String?,
      tglRencana: json['tgl_rencana'] as String?,
      tglPenyelesaian: json['tgl_penyelesaian'] as String?,
      statusValidasi: json['status_validasi'] as int?,
      validasiBy: json['validasi_by'] as int?,
      prioritas: json['prioritas'] as int?,
      status: json['status'] as int?,
      keterangan: json['keterangan'] as String?,
      image: json['image'] as String?,
      output: json['output'] as String?,
      penilaian: json['penilaian'] as int?,
      createdAt: json['created_at'] as int?,
      userName: json['user_name'] as String?,
      depName: json['dep_name'] as String?,
      kategoriRkName: json['kategori_rk_name'] as dynamic,
      validasiByName: json['validasi_by_name'] as dynamic,
      picName: json['pic_name'] as String?,
      requestByName: json['request_by_name'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_pekerjaan': namaPekerjaan,
        'periode': periode,
        'minggu': minggu,
        'tgl_rencana': tglRencana,
        'tgl_penyelesaian': tglPenyelesaian,
        'status_validasi': statusValidasi,
        'validasi_by': validasiBy,
        'prioritas': prioritas,
        'status': status,
        'keterangan': keterangan,
        'image': image,
        'output': output,
        'penilaian': penilaian,
        'created_at': createdAt,
        'user_name': userName,
        'dep_name': depName,
        'kategori_rk_name': kategoriRkName,
        'validasi_by_name': validasiByName,
        'pic_name': picName,
        'request_by_name': requestByName,
      };

  static List<LaporanItDetail> fromJsonList(List? data) {
    return (data ?? []).map((e) => LaporanItDetail.fromJson(e)).toList();
  }
}
