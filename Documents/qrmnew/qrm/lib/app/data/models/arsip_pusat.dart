class ArsipRegPusat {
  int? id;
  int? userId;
  String? files;
  String? tglUpload;
  int? uploadBy;
  int? createdAt;
  String? userName;
  String? uploadName;

  ArsipRegPusat({
    this.id,
    this.userId,
    this.files,
    this.tglUpload,
    this.uploadBy,
    this.createdAt,
    this.userName,
    this.uploadName,
  });

  factory ArsipRegPusat.fromJson(Map<String, dynamic> json) => ArsipRegPusat(
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

  static List<ArsipRegPusat> fromJsonList(List? data) {
    return (data ?? []).map((e) => ArsipRegPusat.fromJson(e)).toList();
  }
}
