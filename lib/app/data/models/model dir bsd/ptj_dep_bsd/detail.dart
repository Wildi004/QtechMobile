import 'sub_detail.dart';

class DetailPtjDep {
  int? id;
  String? noPtjReg;
  String? noPtjDep;
  String? namaPengajuan;
  int? totalHarga;
  String? noHide;
  int? statusAcc;
  String? komentar;
  int? createdAt;
  List<SubDetail>? subDetail;
  String? nomorPtjDepartemen;

  DetailPtjDep({
    this.id,
    this.noPtjReg,
    this.noPtjDep,
    this.namaPengajuan,
    this.totalHarga,
    this.noHide,
    this.statusAcc,
    this.komentar,
    this.createdAt,
    this.subDetail,
    this.nomorPtjDepartemen,
  });

  factory DetailPtjDep.fromJson(Map<String, dynamic> json) => DetailPtjDep(
        id: json['id'] as int?,
        noPtjReg: json['no_ptj_reg'] as String?,
        noPtjDep: json['no_ptj_dep'] as String?,
        namaPengajuan: json['nama_pengajuan'] as String?,
        totalHarga: json['total_harga'] as int?,
        noHide: json['no_hide'] as String?,
        statusAcc: json['status_acc'] as int?,
        komentar: json['komentar'] as String?,
        createdAt: json['created_at'] as int?,
        subDetail: (json['sub_detail'] as List<dynamic>?)
            ?.map((e) => SubDetail.fromJson(e as Map<String, dynamic>))
            .toList(),
        nomorPtjDepartemen: json['nomor_ptj_departemen'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_ptj_reg': noPtjReg,
        'no_ptj_dep': noPtjDep,
        'nama_pengajuan': namaPengajuan,
        'total_harga': totalHarga,
        'no_hide': noHide,
        'status_acc': statusAcc,
        'komentar': komentar,
        'created_at': createdAt,
        'sub_detail': subDetail?.map((e) => e.toJson()).toList(),
        'nomor_ptj_departemen': nomorPtjDepartemen,
      };
}
