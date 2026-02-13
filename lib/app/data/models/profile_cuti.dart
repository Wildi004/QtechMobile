class ProfileCuti {
  int? id;
  int? userId;
  int? depId;
  String? tglCuti;
  String? perihal;
  String? keterangan;
  String? cutiFrom;
  String? cutiTo;
  int? lamaCuti;
  int? statusHrd;
  int? approval;
  int? statusDirKeuangan;
  int? aprrovedBy;
  int? createdAt;
  String? createdIn;
  String? userName;
  String? approvalName;
  dynamic aprrovedByName;
  String? departemen;

  ProfileCuti({
    this.id,
    this.userId,
    this.depId,
    this.tglCuti,
    this.perihal,
    this.keterangan,
    this.cutiFrom,
    this.cutiTo,
    this.lamaCuti,
    this.statusHrd,
    this.approval,
    this.statusDirKeuangan,
    this.aprrovedBy,
    this.createdAt,
    this.createdIn,
    this.userName,
    this.approvalName,
    this.aprrovedByName,
    this.departemen,
  });

  factory ProfileCuti.fromJson(Map<String, dynamic> json) => ProfileCuti(
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        depId: json['dep_id'] as int?,
        tglCuti: json['tgl_cuti'] as String?,
        perihal: json['perihal'] as String?,
        keterangan: json['keterangan'] as String?,
        cutiFrom: json['cuti_from'] as String?,
        cutiTo: json['cuti_to'] as String?,
        lamaCuti: json['lama_cuti'] as int?,
        statusHrd: json['status_hrd'] as int?,
        approval: json['approval'] as int?,
        statusDirKeuangan: json['status_dir_keuangan'] as int?,
        aprrovedBy: json['aprroved_by'] as int?,
        createdAt: json['created_at'] as int?,
        createdIn: json['created_in'] as String?,
        userName: json['user_name'] as String?,
        approvalName: json['approval_name'] as String?,
        aprrovedByName: json['aprroved_by_name'] as dynamic,
        departemen: json['departemen'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'dep_id': depId,
        'tgl_cuti': tglCuti,
        'perihal': perihal,
        'keterangan': keterangan,
        'cuti_from': cutiFrom,
        'cuti_to': cutiTo,
        'lama_cuti': lamaCuti,
        'status_hrd': statusHrd,
        'approval': approval,
        'status_dir_keuangan': statusDirKeuangan,
        'aprroved_by': aprrovedBy,
        'created_at': createdAt,
        'created_in': createdIn,
        'user_name': userName,
        'approval_name': approvalName,
        'aprroved_by_name': aprrovedByName,
        'departemen': departemen,
      };

  static List<ProfileCuti> fromJsonList(List? data) {
    return (data ?? []).map((e) => ProfileCuti.fromJson(e)).toList();
  }
}
