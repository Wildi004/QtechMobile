import 'sub_detail.dart';

class DetailPengajuanBsd {
  int? id;
  String? noPengajuanReg;
  String? noPengajuanDep;
  String? namaPengajuan;
  int? totalHarga;
  int? statusAcc;
  String? komentar;
  String? noHide;
  int? sttsCheck;
  String? nomorPengajuanDepartemen;
  List<SubDetailPengajuanDepBsd>? subDetail;

  DetailPengajuanBsd({
    this.id,
    this.noPengajuanReg,
    this.noPengajuanDep,
    this.namaPengajuan,
    this.totalHarga,
    this.statusAcc,
    this.komentar,
    this.noHide,
    this.sttsCheck,
    this.nomorPengajuanDepartemen,
    this.subDetail,
  });

  factory DetailPengajuanBsd.fromJson(Map<String, dynamic> json) =>
      DetailPengajuanBsd(
        id: json['id'] as int?,
        noPengajuanReg: json['no_pengajuan_reg'] as String?,
        noPengajuanDep: json['no_pengajuan_dep'] as String?,
        namaPengajuan: json['nama_pengajuan'] as String?,
        totalHarga: json['total_harga'] as int?,
        statusAcc: json['status_acc'] as int?,
        komentar: json['komentar'] as String?,
        noHide: json['no_hide'] as String?,
        sttsCheck: json['stts_check'] as int?,
        nomorPengajuanDepartemen: json['nomor_pengajuan_departemen'] as String?,
        subDetail: (json['sub_detail'] as List<dynamic>?)
            ?.map((e) =>
                SubDetailPengajuanDepBsd.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_pengajuan_reg': noPengajuanReg,
        'no_pengajuan_dep': noPengajuanDep,
        'nama_pengajuan': namaPengajuan,
        'total_harga': totalHarga,
        'status_acc': statusAcc,
        'komentar': komentar,
        'no_hide': noHide,
        'stts_check': sttsCheck,
        'nomor_pengajuan_departemen': nomorPengajuanDepartemen,
        'sub_detail': subDetail?.map((e) => e.toJson()).toList(),
      };
}
