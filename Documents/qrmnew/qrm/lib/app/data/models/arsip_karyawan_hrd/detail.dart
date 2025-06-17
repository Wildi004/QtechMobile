class Detail {
  int? id;
  String? filename;
  String? filepath;
  int? tglUpload;
  int? uoloadBy;
  String? uploadName;

  Detail({
    this.id,
    this.filename,
    this.filepath,
    this.tglUpload,
    this.uoloadBy,
    this.uploadName,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
        filename: json['file_name'] as String?,
        filepath: json['file_path'] as String?,
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
        'file_name': filename,
        'file_path': filepath,
        'tgl_upload': tglUpload,
        'uoload_by': uoloadBy,
        'upload_name': uploadName,
      };
}
