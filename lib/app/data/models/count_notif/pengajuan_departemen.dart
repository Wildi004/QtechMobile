class PengajuanDepartemen {
  int? pengajuanIt;
  int? pengajuanHrd;
  int? pengajuanLegal;
  int? pengajuanLogistik;
  int? pengajuanTotal;
  int? pengajuanRnd;

  PengajuanDepartemen(
      {this.pengajuanIt,
      this.pengajuanHrd,
      this.pengajuanLegal,
      this.pengajuanLogistik,
      this.pengajuanTotal,
      this.pengajuanRnd});

  factory PengajuanDepartemen.fromJson(Map<String, dynamic> json) {
    return PengajuanDepartemen(
      pengajuanIt: json['pengajuan_it'] as int?,
      pengajuanHrd: json['pengajuan_hrd'] as int?,
      pengajuanLegal: json['pengajuan_legal'] as int?,
      pengajuanLogistik: json['pengajuan_logistik'] as int?,
      pengajuanTotal: json['pengajuan_total'] as int?,
      pengajuanRnd: json['pengajuan_rnd'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'pengajuan_it': pengajuanIt,
        'pengajuan_hrd': pengajuanHrd,
        'pengajuan_legal': pengajuanLegal,
        'pengajuan_logistik': pengajuanLogistik,
        'pengajuan_total': pengajuanTotal,
        'pengajuan_rnd': pengajuanRnd,
      };
}
