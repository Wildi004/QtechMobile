import 'data.dart';

class Teknik {
  bool? status;
  String? message;
  Data? data;

  Teknik({this.status, this.message, this.data});

  factory Teknik.fromJson(Map<String, dynamic> json) => Teknik(
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
