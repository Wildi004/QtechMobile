import 'data.dart';

class ProjectBarat {
  bool? status;
  String? message;
  Data? data;

  ProjectBarat({this.status, this.message, this.data});

  factory ProjectBarat.fromJson(Map<String, dynamic> json) => ProjectBarat(
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
