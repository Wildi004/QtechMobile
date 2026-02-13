class SaldoKasAwalList {
  int? id;
  int? kodeAkun;
  String? namaAkun;
  int? saldoAwal;

  SaldoKasAwalList({this.id, this.kodeAkun, this.namaAkun, this.saldoAwal});

  factory SaldoKasAwalList.fromJson(Map<String, dynamic> json) {
    return SaldoKasAwalList(
      id: json['id'] as int?,
      kodeAkun: json['kode_akun'] as int?,
      namaAkun: json['nama_akun'] as String?,
      saldoAwal: json['saldo_awal'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_akun': kodeAkun,
        'nama_akun': namaAkun,
        'saldo_awal': saldoAwal,
      };

  static List<SaldoKasAwalList> fromJsonList(List? data) {
    return (data ?? []).map((e) => SaldoKasAwalList.fromJson(e)).toList();
  }
}
