import 'sub.dart';

class CreateLaporan {
  String? keterangan;
  List<Sub>? sub;

  CreateLaporan({this.keterangan, this.sub});

  factory CreateLaporan.fromJson(Map<String, dynamic> json) => CreateLaporan(
        keterangan: json['keterangan'] as String?,
        sub: (json['sub'] as List<dynamic>?)
            ?.map((e) => Sub.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'keterangan': keterangan,
        'sub': sub?.map((e) => e.toJson()).toList(),
      };

  static List<CreateLaporan> fromJsonList(List? data) {
    return (data ?? []).map((e) => CreateLaporan.fromJson(e)).toList();
  }
}
