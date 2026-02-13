class RabDepartemen {
  int? rabDepartemen;

  RabDepartemen({this.rabDepartemen});

  factory RabDepartemen.fromJson(Map<String, dynamic> json) => RabDepartemen(
        rabDepartemen: json['rab_departemen'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'rab_departemen': rabDepartemen,
      };
}
