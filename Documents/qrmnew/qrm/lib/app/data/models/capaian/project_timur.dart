import 'data.dart';

class ProjectTimur {
  bool? status;
  String? message;
  Data? data;

  ProjectTimur({this.status, this.message, this.data});

  factory ProjectTimur.fromJson(Map<String, dynamic> json) => ProjectTimur(
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
