import 'bali_year.dart';

class Timur {
  int? totalBali;
  int? totalFinanceGaji;
  int? total;
  List<BaliYear>? baliYear;

  Timur({this.totalBali, this.totalFinanceGaji, this.total, this.baliYear});

  factory Timur.fromJson(Map<String, dynamic> json) => Timur(
        totalBali: json['total_bali'] as int?,
        totalFinanceGaji: json['total_finance_gaji'] as int?,
        total: json['total'] as int?,
        baliYear: (json['bali_year'] as List<dynamic>?)
            ?.map((e) => BaliYear.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'total_bali': totalBali,
        'total_finance_gaji': totalFinanceGaji,
        'total': total,
        'bali_year': baliYear?.map((e) => e.toJson()).toList(),
      };
}
