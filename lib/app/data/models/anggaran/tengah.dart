class Tengah {
  int? totalTengah;
  int? totalFinanceGajiTgh;
  int? total;
  List<dynamic>? tengahYear;

  Tengah({
    this.totalTengah,
    this.totalFinanceGajiTgh,
    this.total,
    this.tengahYear,
  });

  factory Tengah.fromJson(Map<String, dynamic> json) => Tengah(
        totalTengah: json['total_tengah'] as int?,
        totalFinanceGajiTgh: json['total_finance_gaji_tgh'] as int?,
        total: json['total'] as int?,
        tengahYear: json['tengah_year'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'total_tengah': totalTengah,
        'total_finance_gaji_tgh': totalFinanceGajiTgh,
        'total': total,
        'tengah_year': tengahYear,
      };
}
