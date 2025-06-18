import 'data.dart';

class FinanceTimur {
  bool? status;
  String? message;
  Data? data;

  FinanceTimur({this.status, this.message, this.data});

  factory FinanceTimur.fromJson(Map<String, dynamic> json) => FinanceTimur(
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
