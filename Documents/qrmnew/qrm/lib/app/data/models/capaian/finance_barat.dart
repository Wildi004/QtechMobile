import 'data.dart';

class FinanceBarat {
  bool? status;
  String? message;
  Data? data;

  FinanceBarat({this.status, this.message, this.data});

  factory FinanceBarat.fromJson(Map<String, dynamic> json) => FinanceBarat(
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
