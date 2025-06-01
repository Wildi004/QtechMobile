import 'data.dart';

class Hrd {
  bool? status;
  String? message;
  Data? data;

  Hrd({this.status, this.message, this.data});

  factory Hrd.fromJson(Map<String, dynamic> json) => Hrd(
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
