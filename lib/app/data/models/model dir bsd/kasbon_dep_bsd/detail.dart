import 'detail_kasbon.dart';

class DetailKason {
  int? id;
  String? noPengajuanReg;
  String? noPengajuanDep;
  String? namaPengajuan;
  int? totalHarga;
  String? noHide;
  String? nomorPengajuanDepartemen;
  SubDetailKasbon? detailKasbon;

  DetailKason({
    this.id,
    this.noPengajuanReg,
    this.noPengajuanDep,
    this.namaPengajuan,
    this.totalHarga,
    this.noHide,
    this.nomorPengajuanDepartemen,
    this.detailKasbon,
  });

  factory DetailKason.fromJson(Map<String, dynamic> json) => DetailKason(
        id: json['id'] as int?,
        noPengajuanReg: json['no_pengajuan_reg'] as String?,
        noPengajuanDep: json['no_pengajuan_dep'] as String?,
        namaPengajuan: json['nama_pengajuan'] as String?,
        totalHarga: json['total_harga'] as int?,
        noHide: json['no_hide'] as String?,
        nomorPengajuanDepartemen: json['nomor_pengajuan_departemen'] as String?,
        detailKasbon: json['detail_kasbon'] == null
            ? null
            : SubDetailKasbon.fromJson(
                json['detail_kasbon'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_pengajuan_reg': noPengajuanReg,
        'no_pengajuan_dep': noPengajuanDep,
        'nama_pengajuan': namaPengajuan,
        'total_harga': totalHarga,
        'no_hide': noHide,
        'nomor_pengajuan_departemen': nomorPengajuanDepartemen,
        'detail_kasbon': detailKasbon?.toJson(),
      };
}
