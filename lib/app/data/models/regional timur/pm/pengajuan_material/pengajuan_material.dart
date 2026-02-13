import 'data_proyek_item.dart';

class PengajuanMaterial {
  int? id;
  String? noPengajuan;
  String? tglPengajuan;
  int? depId;
  int? proyekItemId;
  int? subTotal;
  int? approval;
  int? statusGmRegional;
  int? statusDirTeknik;
  int? approvedBy;
  int? createdBy;
  int? createdAt;
  String? createdIn;
  String? noHide;
  int? updatedBy;
  int? sttsCheck;
  String? departemen;
  DataProyekItem? dataProyekItem;

  PengajuanMaterial({
    this.id,
    this.noPengajuan,
    this.tglPengajuan,
    this.depId,
    this.proyekItemId,
    this.subTotal,
    this.approval,
    this.statusGmRegional,
    this.statusDirTeknik,
    this.approvedBy,
    this.createdBy,
    this.createdAt,
    this.createdIn,
    this.noHide,
    this.updatedBy,
    this.sttsCheck,
    this.departemen,
    this.dataProyekItem,
  });

  factory PengajuanMaterial.fromJson(Map<String, dynamic> json) {
    return PengajuanMaterial(
      id: json['id'] as int?,
      noPengajuan: json['no_pengajuan'] as String?,
      tglPengajuan: json['tgl_pengajuan'] as String?,
      depId: json['dep_id'] as int?,
      proyekItemId: json['proyek_item_id'] as int?,
      subTotal: json['sub_total'] as int?,
      approval: json['approval'] as int?,
      statusGmRegional: json['status_gm_regional'] as int?,
      statusDirTeknik: json['status_dir_teknik'] as int?,
      approvedBy: json['approved_by'] as int?,
      createdBy: json['created_by'] as int?,
      createdAt: json['created_at'] as int?,
      createdIn: json['created_in'] as String?,
      noHide: json['no_hide'] as String?,
      updatedBy: json['updated_by'] as int?,
      sttsCheck: json['stts_check'] as int?,
      departemen: json['departemen'] as String?,
      dataProyekItem: json['data_proyek_item'] == null
          ? null
          : DataProyekItem.fromJson(
              json['data_proyek_item'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_pengajuan': noPengajuan,
        'tgl_pengajuan': tglPengajuan,
        'dep_id': depId,
        'proyek_item_id': proyekItemId,
        'sub_total': subTotal,
        'approval': approval,
        'status_gm_regional': statusGmRegional,
        'status_dir_teknik': statusDirTeknik,
        'approved_by': approvedBy,
        'created_by': createdBy,
        'created_at': createdAt,
        'created_in': createdIn,
        'no_hide': noHide,
        'updated_by': updatedBy,
        'stts_check': sttsCheck,
        'departemen': departemen,
        'data_proyek_item': dataProyekItem?.toJson(),
      };

  static List<PengajuanMaterial> fromJsonList(List? data) {
    return (data ?? []).map((e) => PengajuanMaterial.fromJson(e)).toList();
  }
}
