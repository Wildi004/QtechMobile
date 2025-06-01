import 'data.dart';

class Logistik {
  bool? status;
  String? message;
  Data? data;

  Logistik({this.status, this.message, this.data});

  factory Logistik.fromJson(Map<String, dynamic> json) => Logistik(
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
}
