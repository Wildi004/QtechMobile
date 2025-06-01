import 'data.dart';

class SalesTimur {
  bool? status;
  String? message;
  Data? data;

  SalesTimur({this.status, this.message, this.data});

  factory SalesTimur.fromJson(Map<String, dynamic> json) => SalesTimur(
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
