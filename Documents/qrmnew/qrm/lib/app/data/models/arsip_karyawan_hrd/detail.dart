class Detail {
  int? id;
  String? file_name;
  String? file_path;
  int? tglUpload;
  int? uoloadBy;
  String? uploadName;

  Detail({
    this.id,
    this.file_name,
    this.file_path,
    this.tglUpload,
    this.uoloadBy,
    this.uploadName,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
        file_name: json['file_name'] as String?,
        file_path: json['file_path'] as String?,
        tglUpload: json['tgl_upload'] is String
            ? int.tryParse(json['tgl_upload'])
            : json['tgl_upload'],
        uoloadBy: json['uoload_by'] is String
            ? int.tryParse(json['uoload_by'])
            : json['uoload_by'],
        uploadName: json['upload_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'file_name': file_name,
        'file_path': file_path,
        'tgl_upload': tglUpload,
        'uoload_by': uoloadBy,
        'upload_name': uploadName,
      };
}
