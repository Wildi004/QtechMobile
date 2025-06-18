import 'data.dart';

class Legal {
  bool? status;
  String? message;
  Data? data;

  Legal({this.status, this.message, this.data});

  factory Legal.fromJson(Map<String, dynamic> json) => Legal(
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
