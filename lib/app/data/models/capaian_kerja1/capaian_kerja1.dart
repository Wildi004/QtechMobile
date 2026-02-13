import 'team.dart';

class Capaian1 {
  String? departemen;
  String? periodeAwal;
  String? periodeAkhir;
  int? waiting;
  int? progres;
  int? selesai;
  int? gagal;
  int? total;
  List<Team>? team;

  Capaian1({
    this.departemen,
    this.periodeAwal,
    this.periodeAkhir,
    this.waiting,
    this.progres,
    this.selesai,
    this.gagal,
    this.total,
    this.team,
  });

  factory Capaian1.fromJson(Map<String, dynamic> json) => Capaian1(
        departemen: json['departemen'] as String?,
        periodeAwal: json['periode_awal'] as String?,
        periodeAkhir: json['periode_akhir'] as String?,
        waiting: json['waiting'] as int?,
        progres: json['progres'] as int?,
        selesai: json['selesai'] as int?,
        gagal: json['gagal'] as int?,
        total: json['total'] as int?,
        team: (json['team'] as List<dynamic>?)
            ?.map((e) => Team.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'departemen': departemen,
        'periode_awal': periodeAwal,
        'periode_akhir': periodeAkhir,
        'waiting': waiting,
        'progres': progres,
        'selesai': selesai,
        'gagal': gagal,
        'total': total,
        'team': team?.map((e) => e.toJson()).toList(),
      };

  static List<Capaian1> fromJsonList(List? data) {
    return (data ?? []).map((e) => Capaian1.fromJson(e)).toList();
  }
}
