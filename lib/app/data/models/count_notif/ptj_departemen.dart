class PtjDepartemen {
  int? ptjIt;
  int? ptjHrd;
  int? ptjLegal;
  int? ptjLogistik;
  int? ptjTotal;

  PtjDepartemen({
    this.ptjIt,
    this.ptjHrd,
    this.ptjLegal,
    this.ptjLogistik,
    this.ptjTotal,
  });

  factory PtjDepartemen.fromJson(Map<String, dynamic> json) => PtjDepartemen(
        ptjIt: json['ptj_it'] as int?,
        ptjHrd: json['ptj_hrd'] as int?,
        ptjLegal: json['ptj_legal'] as int?,
        ptjLogistik: json['ptj_logistik'] as int?,
        ptjTotal: json['ptj_total'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'ptj_it': ptjIt,
        'ptj_hrd': ptjHrd,
        'ptj_legal': ptjLegal,
        'ptj_logistik': ptjLogistik,
        'ptj_total': ptjTotal,
      };
}
