import 'notulen_detail.dart';

class Notulen {
  int? id;
  String? kode;
  String? tglRapat;
  int? pimpinan;
  String? judul;
  String? jam;
  int? jmlPeserta;
  String? isi;
  int? sifat;
  String? image;
  int? createdBy;
  int? createdAt;
  int? departemen;
  String? pimpinanName;
  String? createdName;
  dynamic sifatName;
  String? departemenName;
  List<NotulenDetail>? notulenDetail;

  Notulen({
    this.id,
    this.kode,
    this.tglRapat,
    this.pimpinan,
    this.judul,
    this.jam,
    this.jmlPeserta,
    this.isi,
    this.sifat,
    this.image,
    this.createdBy,
    this.createdAt,
    this.departemen,
    this.pimpinanName,
    this.createdName,
    this.sifatName,
    this.departemenName,
    this.notulenDetail,
  });

  factory Notulen.fromJson(Map<String, dynamic> json) => Notulen(
        id: json['id'] as int?,
        kode: json['kode'] as String?,
        tglRapat: json['tgl_rapat'] as String?,
        pimpinan: json['pimpinan'] as int?,
        judul: json['judul'] as String?,
        jam: json['jam'] as String?,
        jmlPeserta: json['jml_peserta'] as int?,
        isi: json['isi'] as String?,
        sifat: json['sifat'] as int?,
        image: json['image'] as String?,
        createdBy: json['created_by'] as int?,
        createdAt: json['created_at'] as int?,
        departemen: json['departemen'] as int?,
        pimpinanName: json['pimpinan_name'] as String?,
        createdName: json['created_name'] as String?,
        sifatName: json['sifat_name'] as dynamic,
        departemenName: json['departemen_name'] as String?,
        notulenDetail: (json['notulen_detail'] as List<dynamic>?)
            ?.map((e) => NotulenDetail.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode': kode,
        'tgl_rapat': tglRapat,
        'pimpinan': pimpinan,
        'judul': judul,
        'jam': jam,
        'jml_peserta': jmlPeserta,
        'isi': isi,
        'sifat': sifat,
        'image': image,
        'created_by': createdBy,
        'created_at': createdAt,
        'departemen': departemen,
        'pimpinan_name': pimpinanName,
        'created_name': createdName,
        'sifat_name': sifatName,
        'departemen_name': departemenName,
        'notulen_detail': notulenDetail?.map((e) => e.toJson()).toList(),
      };

  static List<Notulen> fromJsonList(List? data) {
    return (data ?? []).map((e) => Notulen.fromJson(e)).toList();
  }
}
