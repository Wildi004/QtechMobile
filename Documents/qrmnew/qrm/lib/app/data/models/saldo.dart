class Saldo {
  int? id;
  int? subTrans;
  String? keterangan;
  String? tglTerima;
  int? debit;
  int? kredit;
  int? saldo;
  int? depId;
  int? pengirim;
  int? createdAt;
  String? noHide;
  int? proyekItemId;
  int? adendum;
  String? type;
  String? pengirimName;
  String? depName;
  dynamic proyekItemName;

  Saldo({
    this.id,
    this.subTrans,
    this.keterangan,
    this.tglTerima,
    this.debit,
    this.kredit,
    this.saldo,
    this.depId,
    this.pengirim,
    this.createdAt,
    this.noHide,
    this.proyekItemId,
    this.adendum,
    this.type,
    this.pengirimName,
    this.depName,
    this.proyekItemName,
  });

  factory Saldo.fromJson(Map<String, dynamic> json) => Saldo(
        id: json['id'] as int?,
        subTrans: json['sub_trans'] as int?,
        keterangan: json['keterangan'] as String?,
        tglTerima: json['tgl_terima'] as String?,
        debit: json['debit'] as int?,
        kredit: json['kredit'] as int?,
        saldo: json['saldo'] as int?,
        depId: json['dep_id'] as int?,
        pengirim: json['pengirim'] as int?,
        createdAt: json['created_at'] as int?,
        noHide: json['no_hide'] as String?,
        proyekItemId: json['proyek_item_id'] as int?,
        adendum: json['adendum'] as int?,
        type: json['type'] as String?,
        pengirimName: json['pengirim_name'] as String?,
        depName: json['dep_name'] as String?,
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
        'dep_id': depId,
        'pengirim': pengirim,
        'created_at': createdAt,
        'no_hide': noHide,
        'proyek_item_id': proyekItemId,
        'adendum': adendum,
        'type': type,
        'pengirim_name': pengirimName,
        'dep_name': depName,
        'proyek_item_name': proyekItemName,
      };

  static List<Saldo> fromJsonList(List? data) {
    return (data ?? []).map((e) => Saldo.fromJson(e)).toList();
  }
}
