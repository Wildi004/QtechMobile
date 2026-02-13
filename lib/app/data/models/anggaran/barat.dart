import 'jakarta_year.dart';

class Barat {
  int? totalJakarta;
  int? totalFinanceGajiJkt;
  int? total;
  List<JakartaYear>? jakartaYear;

  Barat({
    this.totalJakarta,
    this.totalFinanceGajiJkt,
    this.total,
    this.jakartaYear,
  });

  factory Barat.fromJson(Map<String, dynamic> json) => Barat(
        totalJakarta: json['total_jakarta'] as int?,
        totalFinanceGajiJkt: json['total_finance_gaji_jkt'] as int?,
        total: json['total'] as int?,
        jakartaYear: (json['jakarta_year'] as List<dynamic>?)
            ?.map((e) => JakartaYear.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'total_jakarta': totalJakarta,
        'total_finance_gaji_jkt': totalFinanceGajiJkt,
        'total': total,
        'jakarta_year': jakartaYear?.map((e) => e.toJson()).toList(),
      };
}
