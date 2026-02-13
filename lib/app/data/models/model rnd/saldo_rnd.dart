class SaldoRnd {
  int? id;
  int? subTrans;
  String? keterangan;
  String? tglTerima;
  int? debit;
  int? kredit;
  int? saldo;
  int? createdAt;
  String? noHide;
  int? adendum;
  String? type;
  String? userName;
  String? dep;
  dynamic proyekItemName;

  SaldoRnd({
    this.id,
    this.subTrans,
    this.keterangan,
    this.tglTerima,
    this.debit,
    this.kredit,
    this.saldo,
    this.createdAt,
    this.noHide,
    this.adendum,
    this.type,
    this.userName,
    this.dep,
    this.proyekItemName,
  });

  factory SaldoRnd.fromJson(Map<String, dynamic> json) => SaldoRnd(
        id: json['id'] as int?,
        subTrans: json['sub_trans'] as int?,
        keterangan: json['keterangan'] as String?,
        tglTerima: json['tgl_terima'] as String?,
        debit: json['debit'] as int?,
        kredit: json['kredit'] as int?,
        saldo: json['saldo'] as int?,
        createdAt: json['created_at'] as int?,
        noHide: json['no_hide'] as String?,
        adendum: json['adendum'] as int?,
        type: json['type'] as String?,
        userName: json['user_name'] as String?,
        dep: json['dep'] as String?,
        proyekItemName: json['proyek_item_name'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'sub_trans': subTrans,
        'keterangan': keterangan,
        'tgl_terima': tglTerima,
        'debit': debit,
        'kredit': kredit,
        'saldo': saldo,
        'created_at': createdAt,
        'no_hide': noHide,
        'adendum': adendum,
        'type': type,
        'user_name': userName,
        'dep': dep,
        'proyek_item_name': proyekItemName,
      };

  static List<SaldoRnd> fromJsonList(List? data) {
    return (data ?? []).map((e) => SaldoRnd.fromJson(e)).toList();
  }
}
