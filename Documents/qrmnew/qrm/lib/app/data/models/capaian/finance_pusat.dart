import 'data.dart';

class FinancePusat {
  bool? status;
  String? message;
  Data? data;

  FinancePusat({this.status, this.message, this.data});

  factory FinancePusat.fromJson(Map<String, dynamic> json) => FinancePusat(
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
