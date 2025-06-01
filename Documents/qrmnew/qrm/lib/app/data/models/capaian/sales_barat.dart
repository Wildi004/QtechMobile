import 'data.dart';

class SalesBarat {
  bool? status;
  String? message;
  Data? data;

  SalesBarat({this.status, this.message, this.data});

  factory SalesBarat.fromJson(Map<String, dynamic> json) => SalesBarat(
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
