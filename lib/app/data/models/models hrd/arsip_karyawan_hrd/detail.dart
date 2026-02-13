class ArsivKaryawanDetail {
  int? id;
  String? filename;
  String? filepath;
  int? tglUpload;
  int? uoloadBy;
  String? uploadName;

  ArsivKaryawanDetail({
    this.id,
    this.filename,
    this.filepath,
    this.tglUpload,
    this.uoloadBy,
    this.uploadName,
  });

  factory ArsivKaryawanDetail.fromJson(Map<String, dynamic> json) =>
      ArsivKaryawanDetail(
        id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
        filename: json['filename'] ?? json['file_name'],
        filepath: json['filepath'] ?? json['file_path'],
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
        'filename': filename,
        'filepath': filepath,
        'tgl_upload': tglUpload,
        'uoload_by': uoloadBy,
        'upload_name': uploadName,
      };

  static List<ArsivKaryawanDetail> fromJsonList(List? data) {
    return (data ?? []).map((e) => ArsivKaryawanDetail.fromJson(e)).toList();
  }
}
