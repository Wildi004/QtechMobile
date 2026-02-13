class PusatYear {
  int? year;
  int? totalAmount;

  PusatYear({this.year, this.totalAmount});

  factory PusatYear.fromJson(Map<String, dynamic> json) => PusatYear(
        year: json['year'] as int?,
        totalAmount: json['total_amount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'year': year,
        'total_amount': totalAmount,
      };
}
