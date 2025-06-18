import 'data.dart';

class It {
  bool? status;
  String? message;
  Data? data;

  It({this.status, this.message, this.data});

  factory It.fromJson(Map<String, dynamic> json) => It(
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
