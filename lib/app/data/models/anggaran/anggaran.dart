import 'barat.dart';
import 'pusat.dart';
import 'tengah.dart';
import 'timur.dart';

class Anggaran {
  Pusat? pusat;
  Timur? timur;
  Tengah? tengah;
  Barat? barat;

  Anggaran({this.pusat, this.timur, this.tengah, this.barat});

  factory Anggaran.fromJson(Map<String, dynamic> json) => Anggaran(
        pusat: json['pusat'] == null
            ? null
            : Pusat.fromJson(json['pusat'] as Map<String, dynamic>),
        timur: json['timur'] == null
            ? null
            : Timur.fromJson(json['timur'] as Map<String, dynamic>),
        tengah: json['tengah'] == null
            ? null
            : Tengah.fromJson(json['tengah'] as Map<String, dynamic>),
        barat: json['barat'] == null
            ? null
            : Barat.fromJson(json['barat'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'pusat': pusat?.toJson(),
        'timur': timur?.toJson(),
        'tengah': tengah?.toJson(),
        'barat': barat?.toJson(),
      };

  static List<Anggaran> fromJsonList(List? data) {
    return (data ?? []).map((e) => Anggaran.fromJson(e)).toList();
  }
}
