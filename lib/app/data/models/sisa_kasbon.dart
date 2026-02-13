class SisaKasbon {
  String? totalDebit;
  String? totalKredit;
  String? sisaSaldo;

  SisaKasbon({this.totalDebit, this.totalKredit, this.sisaSaldo});

  factory SisaKasbon.fromJson(Map<String, dynamic> json) => SisaKasbon(
        totalDebit: json['totalDebit'] as String?,
        totalKredit: json['totalKredit'] as String?,
        sisaSaldo: json['sisaSaldo'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'totalDebit': totalDebit,
        'totalKredit': totalKredit,
        'sisaSaldo': sisaSaldo,
      };
}
