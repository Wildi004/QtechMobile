import 'pusat_year.dart';

class Pusat {
  int? totalPusat;
  int? totalHrdGaji;
  int? total;
  List<PusatYear>? pusatYear;

  Pusat({this.totalPusat, this.totalHrdGaji, this.total, this.pusatYear});

  factory Pusat.fromJson(Map<String, dynamic> json) => Pusat(
        totalPusat: json['total_pusat'] as int?,
        totalHrdGaji: json['total_hrd_gaji'] as int?,
        total: json['total'] as int?,
        pusatYear: (json['pusat_year'] as List<dynamic>?)
            ?.map((e) => PusatYear.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'total_pusat': totalPusat,
        'total_hrd_gaji': totalHrdGaji,
        'total': total,
        'pusat_year': pusatYear?.map((e) => e.toJson()).toList(),
      };
}
