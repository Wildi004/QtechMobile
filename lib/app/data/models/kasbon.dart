class Kasbon {
  int? id;
  String? noPengajuan;
  String? keterangan;
  int? userId;
  int? depId;
  int? status;
  int? jml;
  String? tglKasbon;
  String? tglTerima;
  int? statusGm;
  int? approval;
  int? statusDirKeuangan;
  int? approvedBy;
  int? statusDirut;
  int? approvedDirut;
  int? createdAt;
  int? createdBy;
  String? noHide;
  String? noHideBkk;
  int? sttsCheck;
  String? user;
  String? dep;
  dynamic approvalName;
  String? approvedByName;
  String? approvedDirutName;
  dynamic createdByName;

  Kasbon({
    this.id,
    this.noPengajuan,
    this.keterangan,
    this.userId,
    this.depId,
    this.status,
    this.jml,
    this.tglKasbon,
    this.tglTerima,
    this.statusGm,
    this.approval,
    this.statusDirKeuangan,
    this.approvedBy,
    this.statusDirut,
    this.approvedDirut,
    this.createdAt,
    this.createdBy,
    this.noHide,
    this.noHideBkk,
    this.sttsCheck,
    this.user,
    this.dep,
    this.approvalName,
    this.approvedByName,
    this.approvedDirutName,
    this.createdByName,
  });

  factory Kasbon.fromJson(Map<String, dynamic> json) => Kasbon(
        id: json['id'] as int?,
        noPengajuan: json['no_pengajuan'] as String?,
        keterangan: json['keterangan'] as String?,
        userId: json['user_id'] as int?,
        depId: json['dep_id'] as int?,
        status: json['status'] as int?,
        jml: json['jml'] is int
            ? json['jml']
            : int.tryParse(json['jml']?.toString() ?? '0'),
        tglKasbon: json['tgl_kasbon'] as String?,
        tglTerima: json['tgl_terima'] as String?,
        statusGm: json['status_gm'] as int?,
        approval: json['approval'] as int?,
        statusDirKeuangan: json['status_dir_keuangan'] as int?,
        approvedBy: json['approved_by'] as int?,
        statusDirut: json['status_dirut'] as int?,
        approvedDirut: json['approved_dirut'] as int?,
        createdAt: json['created_at'] as int?,
        createdBy: json['created_by'] as int?,
        noHide: json['no_hide'] as String?,
        noHideBkk: json['no_hide_bkk'] as String?,
        sttsCheck: json['stts_check'] as int?,
        user: json['user'] as String?,
        dep: json['dep'] as String?,
        approvalName: json['approval_name'] as dynamic,
        approvedByName: json['approved_by_name'] as String?,
        approvedDirutName: json['approved_dirut_name'] as String?,
        createdByName: json['created_by_name'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_pengajuan': noPengajuan,
        'keterangan': keterangan,
        'user_id': userId,
        'dep_id': depId,
        'status': status,
        'jml': jml,
        'tgl_kasbon': tglKasbon,
        'tgl_terima': tglTerima,
        'status_gm': statusGm,
        'approval': approval,
        'status_dir_keuangan': statusDirKeuangan,
        'approved_by': approvedBy,
        'status_dirut': statusDirut,
        'approved_dirut': approvedDirut,
        'created_at': createdAt,
        'created_by': createdBy,
        'no_hide': noHide,
        'no_hide_bkk': noHideBkk,
        'stts_check': sttsCheck,
        'user': user,
        'dep': dep,
        'approval_name': approvalName,
        'approved_by_name': approvedByName,
        'approved_dirut_name': approvedDirutName,
        'created_by_name': createdByName,
      };

  static List<Kasbon> fromJsonList(List? data) {
    return (data ?? []).map((e) => Kasbon.fromJson(e)).toList();
  }
}
