import 'surat_keluar_detail.dart';

class SuratMasuk {
  int? id;
  String? sifat;
  String? perihal;
  String? tglSurat;
  String? image;
  int? statusValidasi;
  String? keterangan;
  int? createdAt;
  String? noHide;
  String? userPenerima;
  dynamic validasiByName;
  String? createdByName;
  String? departemen;
  String? imagePath;
  List<SuratKeluarDetail>? suratKeluarDetail;

  SuratMasuk({
    this.id,
    this.sifat,
    this.perihal,
    this.tglSurat,
    this.image,
    this.statusValidasi,
    this.keterangan,
    this.createdAt,
    this.noHide,
    this.userPenerima,
    this.validasiByName,
    this.createdByName,
    this.departemen,
    this.imagePath,
    this.suratKeluarDetail,
  });

  factory SuratMasuk.fromJson(Map<String, dynamic> json) => SuratMasuk(
        id: json['id'] as int?,
        sifat: json['sifat'] as String?,
        perihal: json['perihal'] as String?,
        tglSurat: json['tgl_surat'] as String?,
        image: json['image'] as String?,
        statusValidasi: json['status_validasi'] as int?,
        keterangan: json['keterangan'] as String?,
        createdAt: json['created_at'] as int?,
        noHide: json['no_hide'] as String?,
        userPenerima: json['user_penerima'] as String?,
        validasiByName: json['validasi_by_name'] as dynamic,
        createdByName: json['created_by_name'] as String?,
        departemen: json['departemen'] as String?,
        imagePath: json['image_path'] as String?,
        suratKeluarDetail: (json['surat_keluar_detail'] as List<dynamic>?)
            ?.map((e) => SuratKeluarDetail.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'sifat': sifat,
        'perihal': perihal,
        'tgl_surat': tglSurat,
        'image': image,
        'status_validasi': statusValidasi,
        'keterangan': keterangan,
        'created_at': createdAt,
        'no_hide': noHide,
        'user_penerima': userPenerima,
        'validasi_by_name': validasiByName,
        'created_by_name': createdByName,
        'departemen': departemen,
        'image_path': imagePath,
        'surat_keluar_detail':
            suratKeluarDetail?.map((e) => e.toJson()).toList(),
      };

  static List<SuratMasuk> fromJsonList(List? data) {
    return (data ?? []).map((e) => SuratMasuk.fromJson(e)).toList();
  }
}
