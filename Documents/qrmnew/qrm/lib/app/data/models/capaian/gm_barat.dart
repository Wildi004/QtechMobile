import 'data.dart';

class GmBarat {
  bool? status;
  String? message;
  Data? data;

  GmBarat({this.status, this.message, this.data});

  factory GmBarat.fromJson(Map<String, dynamic> json) => GmBarat(
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
