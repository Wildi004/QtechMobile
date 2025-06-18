import 'data.dart';

class GmTimur {
  bool? status;
  String? message;
  Data? data;

  GmTimur({this.status, this.message, this.data});

  factory GmTimur.fromJson(Map<String, dynamic> json) => GmTimur(
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
