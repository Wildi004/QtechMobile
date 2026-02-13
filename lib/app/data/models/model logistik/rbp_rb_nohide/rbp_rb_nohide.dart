import 'akomodasi.dart';
import 'alat_tambahan.dart';
import 'alat_utama.dart';
import 'material_tambahan.dart';
import 'material_utama.dart';
import 'proyek.dart';
import 'upah_tenaga.dart';

class RbpRbNohide {
  int? id;
  String? kodeRbp;
  String? kodeProyek;
  String? totalMaterialUtama;
  String? totalMaterialTambahan;
  String? totalUpahTk;
  String? totalByAlatUtama;
  String? totalByAlatTambahan;
  String? totalBiayaAkomodasi;
  String? totalBebanProyek;
  String? nilaiKontrak;
  String? nilaiPendapatan95;
  String? mFeeKantor;
  String? kFeeKantor;
  String? pph;
  String? dppPph;
  String? ppn;
  String? scf;
  String? netto;
  String? estimasiLaba;
  String? retensi;
  String? prestasiLaba;
  int? preparedBy;
  int? statusPm;
  int? validasiPm;
  int? statusGm;
  int? validasiGm;
  int? statusDirtek;
  int? validasiDirtek;
  int? statusBsd;
  int? validasiBsd;
  int? approval;
  int? statusDirKeuangan;
  int? approvedBy;
  int? statusDirUtama;
  int? createdAt;
  String? noHideRbp;
  String? validasiPmName;
  String? validasiGmName;
  String? validasiDirtekName;
  String? validasiBsdName;
  String? approvalName;
  dynamic approvedByName;
  Proyek? proyek;
  List<MaterialUtama>? materialUtama;
  List<MaterialTambahan>? materialTambahan;
  List<UpahTenaga>? upahTenaga;
  List<AlatUtama>? alatUtama;
  List<AlatTambahan>? alatTambahan;
  List<Akomodasi>? akomodasi;

  RbpRbNohide({
    this.id,
    this.kodeRbp,
    this.kodeProyek,
    this.totalMaterialUtama,
    this.totalMaterialTambahan,
    this.totalUpahTk,
    this.totalByAlatUtama,
    this.totalByAlatTambahan,
    this.totalBiayaAkomodasi,
    this.totalBebanProyek,
    this.nilaiKontrak,
    this.nilaiPendapatan95,
    this.mFeeKantor,
    this.kFeeKantor,
    this.pph,
    this.dppPph,
    this.ppn,
    this.scf,
    this.netto,
    this.estimasiLaba,
    this.retensi,
    this.prestasiLaba,
    this.preparedBy,
    this.statusPm,
    this.validasiPm,
    this.statusGm,
    this.validasiGm,
    this.statusDirtek,
    this.validasiDirtek,
    this.statusBsd,
    this.validasiBsd,
    this.approval,
    this.statusDirKeuangan,
    this.approvedBy,
    this.statusDirUtama,
    this.createdAt,
    this.noHideRbp,
    this.validasiPmName,
    this.validasiGmName,
    this.validasiDirtekName,
    this.validasiBsdName,
    this.approvalName,
    this.approvedByName,
    this.proyek,
    this.materialUtama,
    this.materialTambahan,
    this.upahTenaga,
    this.alatUtama,
    this.alatTambahan,
    this.akomodasi,
  });

  factory RbpRbNohide.fromJson(Map<String, dynamic> json) => RbpRbNohide(
        id: json['id'] as int?,
        kodeRbp: json['kode_rbp'] as String?,
        kodeProyek: json['kode_proyek'] as String?,
        totalMaterialUtama: json['total_material_utama'] as String?,
        totalMaterialTambahan: json['total_material_tambahan'] as String?,
        totalUpahTk: json['total_upah_tk'] as String?,
        totalByAlatUtama: json['total_by_alat_utama'] as String?,
        totalByAlatTambahan: json['total_by_alat_tambahan'] as String?,
        totalBiayaAkomodasi: json['total_biaya_akomodasi'] as String?,
        totalBebanProyek: json['total_beban_proyek'] as String?,
        nilaiKontrak: json['nilai_kontrak'] as String?,
        nilaiPendapatan95: json['nilai_pendapatan_95'] as String?,
        mFeeKantor: json['m_fee_kantor'] as String?,
        kFeeKantor: json['k_fee_kantor'] as String?,
        pph: json['pph'] as String?,
        dppPph: json['dpp_pph'] as String?,
        ppn: json['ppn'] as String?,
        scf: json['scf'] as String?,
        netto: json['netto'] as String?,
        estimasiLaba: json['estimasi_laba'] as String?,
        retensi: json['retensi'] as String?,
        prestasiLaba: json['prestasi_laba'] as String?,
        preparedBy: json['prepared_by'] as int?,
        statusPm: json['status_pm'] as int?,
        validasiPm: json['validasi_pm'] as int?,
        statusGm: json['status_gm'] as int?,
        validasiGm: json['validasi_gm'] as int?,
        statusDirtek: json['status_dirtek'] as int?,
        validasiDirtek: json['validasi_dirtek'] as int?,
        statusBsd: json['status_bsd'] as int?,
        validasiBsd: json['validasi_bsd'] as int?,
        approval: json['approval'] as int?,
        statusDirKeuangan: json['status_dir_keuangan'] as int?,
        approvedBy: json['approved_by'] as int?,
        statusDirUtama: json['status_dir_utama'] as int?,
        createdAt: json['created_at'] as int?,
        noHideRbp: json['no_hide_rbp'] as String?,
        validasiPmName: json['validasi_pm_name'] as String?,
        validasiGmName: json['validasi_gm_name'] as String?,
        validasiDirtekName: json['validasi_dirtek_name'] as String?,
        validasiBsdName: json['validasi_bsd_name'] as String?,
        approvalName: json['approval_name'] as String?,
        approvedByName: json['approved_by_name'] as dynamic,
        proyek: json['proyek'] == null
            ? null
            : Proyek.fromJson(json['proyek'] as Map<String, dynamic>),
        materialUtama: (json['material_utama'] as List<dynamic>?)
            ?.map((e) => MaterialUtama.fromJson(e as Map<String, dynamic>))
            .toList(),
        materialTambahan: (json['material_tambahan'] as List<dynamic>?)
            ?.map((e) => MaterialTambahan.fromJson(e as Map<String, dynamic>))
            .toList(),
        upahTenaga: (json['upah_tenaga'] as List<dynamic>?)
            ?.map((e) => UpahTenaga.fromJson(e as Map<String, dynamic>))
            .toList(),
        alatUtama: (json['alat_utama'] as List<dynamic>?)
            ?.map((e) => AlatUtama.fromJson(e as Map<String, dynamic>))
            .toList(),
        alatTambahan: (json['alat_tambahan'] as List<dynamic>?)
            ?.map((e) => AlatTambahan.fromJson(e as Map<String, dynamic>))
            .toList(),
        akomodasi: (json['akomodasi'] as List<dynamic>?)
            ?.map((e) => Akomodasi.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_rbp': kodeRbp,
        'kode_proyek': kodeProyek,
        'total_material_utama': totalMaterialUtama,
        'total_material_tambahan': totalMaterialTambahan,
        'total_upah_tk': totalUpahTk,
        'total_by_alat_utama': totalByAlatUtama,
        'total_by_alat_tambahan': totalByAlatTambahan,
        'total_biaya_akomodasi': totalBiayaAkomodasi,
        'total_beban_proyek': totalBebanProyek,
        'nilai_kontrak': nilaiKontrak,
        'nilai_pendapatan_95': nilaiPendapatan95,
        'm_fee_kantor': mFeeKantor,
        'k_fee_kantor': kFeeKantor,
        'pph': pph,
        'dpp_pph': dppPph,
        'ppn': ppn,
        'scf': scf,
        'netto': netto,
        'estimasi_laba': estimasiLaba,
        'retensi': retensi,
        'prestasi_laba': prestasiLaba,
        'prepared_by': preparedBy,
        'status_pm': statusPm,
        'validasi_pm': validasiPm,
        'status_gm': statusGm,
        'validasi_gm': validasiGm,
        'status_dirtek': statusDirtek,
        'validasi_dirtek': validasiDirtek,
        'status_bsd': statusBsd,
        'validasi_bsd': validasiBsd,
        'approval': approval,
        'status_dir_keuangan': statusDirKeuangan,
        'approved_by': approvedBy,
        'status_dir_utama': statusDirUtama,
        'created_at': createdAt,
        'no_hide_rbp': noHideRbp,
        'validasi_pm_name': validasiPmName,
        'validasi_gm_name': validasiGmName,
        'validasi_dirtek_name': validasiDirtekName,
        'validasi_bsd_name': validasiBsdName,
        'approval_name': approvalName,
        'approved_by_name': approvedByName,
        'proyek': proyek?.toJson(),
        'material_utama': materialUtama?.map((e) => e.toJson()).toList(),
        'material_tambahan': materialTambahan?.map((e) => e.toJson()).toList(),
        'upah_tenaga': upahTenaga?.map((e) => e.toJson()).toList(),
        'alat_utama': alatUtama?.map((e) => e.toJson()).toList(),
        'alat_tambahan': alatTambahan?.map((e) => e.toJson()).toList(),
        'akomodasi': akomodasi?.map((e) => e.toJson()).toList(),
      };

  static List<RbpRbNohide> fromJsonList(List? data) {
    return (data ?? []).map((e) => RbpRbNohide.fromJson(e)).toList();
  }
}
