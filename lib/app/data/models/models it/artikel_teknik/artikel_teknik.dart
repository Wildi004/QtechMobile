import 'foto.dart';

class ArtikelTeknik {
  int? id;
  String? judul;
  String? keterangan;
  String? file;
  int? statusValidasi;
  int? validasiBy;
  int? statusUpload;
  String? tglUpload;
  String? urlArtikel;
  int? uploadedBy;
  int? createdAt;
  int? createdBy;
  List<Foto>? fotos;

  ArtikelTeknik({
    this.id,
    this.judul,
    this.keterangan,
    this.file,
    this.statusValidasi,
    this.validasiBy,
    this.statusUpload,
    this.tglUpload,
    this.urlArtikel,
    this.uploadedBy,
    this.createdAt,
    this.createdBy,
    this.fotos,
  });

  factory ArtikelTeknik.fromJson(Map<String, dynamic> json) => ArtikelTeknik(
        id: json['id'] as int?,
        judul: json['judul'] as String?,
        keterangan: json['keterangan'] as String?,
        file: json['file'] as String?,
        statusValidasi: json['status_validasi'] as int?,
        validasiBy: json['validasi_by'] as int?,
        statusUpload: json['status_upload'] as int?,
        tglUpload: json['tgl_upload'] as String?,
        urlArtikel: json['url_artikel'] as String?,
        uploadedBy: json['uploaded_by'] as int?,
        createdAt: json['created_at'] as int?,
        createdBy: json['created_by'] as int?,
        fotos: (json['fotos'] as List<dynamic>?)
            ?.map((e) => Foto.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'judul': judul,
        'keterangan': keterangan,
        'file': file,
        'status_validasi': statusValidasi,
        'validasi_by': validasiBy,
        'status_upload': statusUpload,
        'tgl_upload': tglUpload,
        'url_artikel': urlArtikel,
        'uploaded_by': uploadedBy,
        'created_at': createdAt,
        'created_by': createdBy,
        'fotos': fotos?.map((e) => e.toJson()).toList(),
      };

  static List<ArtikelTeknik> fromJsonList(List? data) {
    return (data ?? []).map((e) => ArtikelTeknik.fromJson(e)).toList();
  }
}
