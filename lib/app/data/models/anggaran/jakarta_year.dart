class JakartaYear {
  int? year;
  int? totalAmount;

  JakartaYear({this.year, this.totalAmount});

  factory JakartaYear.fromJson(Map<String, dynamic> json) => JakartaYear(
        year: json['year'] as int?,
        totalAmount: json['total_amount'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'year': year,
        'total_amount': totalAmount,
      };
}
