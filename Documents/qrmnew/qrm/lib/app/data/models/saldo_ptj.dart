class SaldoPtj {
  int? saldoAkhir;
  String? saldoAkhirFormat;
  int? saldoSebelumnya;
  String? saldoSebelumnyaFormat;

  SaldoPtj({
    this.saldoAkhir,
    this.saldoAkhirFormat,
    this.saldoSebelumnya,
    this.saldoSebelumnyaFormat,
  });

  factory SaldoPtj.fromJson(Map<String, dynamic> json) => SaldoPtj(
        saldoAkhir: json['saldo_akhir'] as int?,
        saldoAkhirFormat: json['saldo_akhir_format'] as String?,
        saldoSebelumnya: json['saldo_sebelumnya'] as int?,
        saldoSebelumnyaFormat: json['saldo_sebelumnya_format'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'saldo_akhir': saldoAkhir,
        'saldo_akhir_format': saldoAkhirFormat,
        'saldo_sebelumnya': saldoSebelumnya,
        'saldo_sebelumnya_format': saldoSebelumnyaFormat,
      };
  
  static List<SaldoPtj> fromJsonList(List? data) {
    return (data ?? []).map((e) => SaldoPtj.fromJson(e)).toList();
  }
}