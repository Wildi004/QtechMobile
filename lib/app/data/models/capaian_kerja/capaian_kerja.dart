import 'data.dart';

class CapaianKerja {
  bool? status;
  String? message;
  Data? data;

  CapaianKerja({this.status, this.message, this.data});

  factory CapaianKerja.fromJson(Map<String, dynamic> json) => CapaianKerja(
        status: json['status'] as bool?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };

  static List<CapaianKerja> fromJsonList(List? data) {
    return (data ?? []).map((e) => CapaianKerja.fromJson(e)).toList();
  }
}
