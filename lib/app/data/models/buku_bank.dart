class BukuBank {
  int? id;
  String? keterangan;
  int? debit;
  int? kredit;
  String? tglJurnal;
  int? createdBy;
  String? name;

  BukuBank({
    this.id,
    this.keterangan,
    this.debit,
    this.kredit,
    this.tglJurnal,
    this.createdBy,
    this.name,
  });

  factory BukuBank.fromJson(Map<String, dynamic> json) => BukuBank(
        id: json['id'] as int?,
        keterangan: json['keterangan'] as String?,
        debit: json['debit'] as int?,
        kredit: json['kredit'] as int?,
        tglJurnal: json['tgl_jurnal'] as String?,
        createdBy: json['created_by'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'keterangan': keterangan,
        'debit': debit,
        'kredit': kredit,
        'tgl_jurnal': tglJurnal,
        'created_by': createdBy,
        'name': name,
      };

  static List<BukuBank> fromJsonList(List? data) {
    return (data ?? []).map((e) => BukuBank.fromJson(e)).toList();
  }
}
