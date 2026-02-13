class SaldoDepBsd {
  int? id;
  int? headTrans;
  int? subTrans;
  String? keterangan;
  String? tglTerima;
  int? debit;
  int? kredit;
  int? saldo;
  int? depId;
  int? pengirim;
  int? createdAt;
  String? userName;
  String? dep;

  SaldoDepBsd({
    this.id,
    this.headTrans,
    this.subTrans,
    this.keterangan,
    this.tglTerima,
    this.debit,
    this.kredit,
    this.saldo,
    this.depId,
    this.pengirim,
    this.createdAt,
    this.userName,
    this.dep,
  });

  factory SaldoDepBsd.fromJson(Map<String, dynamic> json) => SaldoDepBsd(
        id: json['id'] as int?,
        headTrans: json['head_trans'] as int?,
        subTrans: json['sub_trans'] as int?,
        keterangan: json['keterangan'] as String?,
        tglTerima: json['tgl_terima'] as String?,
        debit: json['debit'] as int?,
        kredit: json['kredit'] as int?,
        saldo: json['saldo'] as int?,
        depId: json['dep_id'] as int?,
        pengirim: json['pengirim'] as int?,
        createdAt: json['created_at'] as int?,
        userName: json['user_name'] as String?,
        dep: json['dep'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'head_trans': headTrans,
        'sub_trans': subTrans,
        'keterangan': keterangan,
        'tgl_terima': tglTerima,
        'debit': debit,
        'kredit': kredit,
        'saldo': saldo,
        'dep_id': depId,
        'pengirim': pengirim,
        'created_at': createdAt,
        'user_name': userName,
        'dep': dep,
      };

  static List<SaldoDepBsd> fromJsonList(List? data) {
    return (data ?? []).map((e) => SaldoDepBsd.fromJson(e)).toList();
  }
}
