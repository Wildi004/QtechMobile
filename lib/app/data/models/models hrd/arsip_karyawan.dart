class ArsipKaryawan {
  int? id;
  int? userId;
  String? files;
  String? tglUpload;
  int? uploadBy;
  int? createdAt;
  String? userName;
  String? uploadName;

  ArsipKaryawan({
    this.id,
    this.userId,
    this.files,
    this.tglUpload,
    this.uploadBy,
    this.createdAt,
    this.userName,
    this.uploadName,
  });
  factory ArsipKaryawan.fromJson(Map<String, dynamic> json) => ArsipKaryawan(
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        files: json['files'] as String?,
        tglUpload: json['tgl_upload'] as String?,
        uploadBy: json['upload_by'] as int?,
        createdAt: json['created_at'] as int?,
        userName: json['user_name'] as String?,
        uploadName: json['upload_name'] as String?,
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'files': files,
        'tgl_upload': tglUpload,
        'upload_by': uploadBy,
        'created_at': createdAt,
        'user_name': userName,
        'upload_name': uploadName,
      };
  static List<ArsipKaryawan> fromJsonList(List? data) {
    return (data ?? []).map((e) => ArsipKaryawan.fromJson(e)).toList();
  }
}
