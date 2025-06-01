import 'detail.dart';

class ArsipKaryawanHrd {
  int? userId;
  String? name;
  String? regional;
  String? departemen;
  List<Detail>? detail;

  ArsipKaryawanHrd(
      {this.name, this.detail, this.regional, this.departemen, this.userId});

  factory ArsipKaryawanHrd.fromJson(Map<String, dynamic> json) {
    return ArsipKaryawanHrd(
      userId: json['user_id'] as int?,
      name: json['name'] as String?,
      regional: json['regional'] as String?,
      departemen: json['departemen'] as String?,
      detail: (json['detail'] as List<dynamic>?)
          ?.map((e) => Detail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'name': name,
        'regional': regional,
        'departemen': departemen,
        'detail': detail?.map((e) => e.toJson()).toList(),
      };

  static List<ArsipKaryawanHrd> fromJsonList(List? data) {
    return (data ?? []).map((e) => ArsipKaryawanHrd.fromJson(e)).toList();
  }
}
