import 'team.dart';

class Data {
  String? periodeAwal;
  String? periodeAkhir;
  int? waiting;
  int? progres;
  int? tercapai;
  int? gagal;
  int? total;
  List<Team>? team;

  Data({
    this.periodeAwal,
    this.periodeAkhir,
    this.waiting,
    this.progres,
    this.tercapai,
    this.gagal,
    this.total,
    this.team,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        periodeAwal: json['periode_awal'] as String?,
        periodeAkhir: json['periode_akhir'] as String?,
        waiting: json['waiting'] as int?,
        progres: json['progres'] as int?,
        tercapai: json['tercapai'] as int?,
        gagal: json['gagal'] as int?,
        total: json['total'] as int?,
        team: (json['team'] as List<dynamic>?)
            ?.map((e) => Team.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'periode_awal': periodeAwal,
        'periode_akhir': periodeAkhir,
        'waiting': waiting,
        'progres': progres,
        'tercapai': tercapai,
        'gagal': gagal,
        'total': total,
        'team': team?.map((e) => e.toJson()).toList(),
      };
}
