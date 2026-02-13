class BaliYear {
  int? year;
  int? totalAmount;

  BaliYear({this.year, this.totalAmount});

  factory BaliYear.fromJson(Map<String, dynamic> json) => BaliYear(
        year: json['year'] as int?,
        totalAmount: json['total_amount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'year': year,
        'total_amount': totalAmount,
      };
}
