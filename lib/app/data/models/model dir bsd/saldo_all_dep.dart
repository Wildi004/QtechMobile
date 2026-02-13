class SaldoAllDep {
  int? saldoAkhirBsd;
  String? saldoAkhirBsdFormat;
  int? saldoAkhirIt;
  String? saldoAkhirItFormat;
  int? saldoAkhirHrd;
  String? saldoAkhirHrdFormat;
  int? saldoAkhirLegal;
  String? saldoAkhirLegalFormat;
  int? saldoAkhirLogistik;
  String? saldoAkhirLogistikFormat;

  SaldoAllDep({
    this.saldoAkhirBsd,
    this.saldoAkhirBsdFormat,
    this.saldoAkhirIt,
    this.saldoAkhirItFormat,
    this.saldoAkhirHrd,
    this.saldoAkhirHrdFormat,
    this.saldoAkhirLegal,
    this.saldoAkhirLegalFormat,
    this.saldoAkhirLogistik,
    this.saldoAkhirLogistikFormat,
  });

  factory SaldoAllDep.fromJson(Map<String, dynamic> json) => SaldoAllDep(
        saldoAkhirBsd: json['saldo_akhir_bsd'] as int?,
        saldoAkhirBsdFormat: json['saldo_akhir_bsd_format'] as String?,
        saldoAkhirIt: json['saldo_akhir_it'] as int?,
        saldoAkhirItFormat: json['saldo_akhir_it_format'] as String?,
        saldoAkhirHrd: json['saldo_akhir_hrd'] as int?,
        saldoAkhirHrdFormat: json['saldo_akhir_hrd_format'] as String?,
        saldoAkhirLegal: json['saldo_akhir_legal'] as int?,
        saldoAkhirLegalFormat: json['saldo_akhir_legal_format'] as String?,
        saldoAkhirLogistik: json['saldo_akhir_logistik'] as int?,
        saldoAkhirLogistikFormat:
            json['saldo_akhir_logistik_format'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'saldo_akhir_bsd': saldoAkhirBsd,
        'saldo_akhir_bsd_format': saldoAkhirBsdFormat,
        'saldo_akhir_it': saldoAkhirIt,
        'saldo_akhir_it_format': saldoAkhirItFormat,
        'saldo_akhir_hrd': saldoAkhirHrd,
        'saldo_akhir_hrd_format': saldoAkhirHrdFormat,
        'saldo_akhir_legal': saldoAkhirLegal,
        'saldo_akhir_legal_format': saldoAkhirLegalFormat,
        'saldo_akhir_logistik': saldoAkhirLogistik,
        'saldo_akhir_logistik_format': saldoAkhirLogistikFormat,
      };
}
