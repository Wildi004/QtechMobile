class DokKenLegal {
  int? id;
  String? keterangan;
  String? tglInput;
  String? tglPengurusan;
  String? tglExp;
  String? image;
  int? createdAt;
  String? createdByName;

  DokKenLegal({
    this.id,
    this.keterangan,
    this.tglInput,
    this.tglPengurusan,
    this.tglExp,
    this.image,
    this.createdAt,
    this.createdByName,
  });

  factory DokKenLegal.fromJson(Map<String, dynamic> json) => DokKenLegal(
        id: json['id'] as int?,
        keterangan: json['keterangan'] as String?,
        tglInput: json['tgl_input'] as String?,
        tglPengurusan: json['tgl_pengurusan'] as String?,
        tglExp: json['tgl_exp'] as String?,
        image: json['image'] as String?,
        createdAt: json['created_at'] as int?,
        createdByName: json['created_by_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'keterangan': keterangan,
        'tgl_input': tglInput,
        'tgl_pengurusan': tglPengurusan,
        'tgl_exp': tglExp,
        'image': image,
        'created_at': createdAt,
        'created_by_name': createdByName,
      };

  static List<DokKenLegal> fromJsonList(List? data) {
    return (data ?? []).map((e) => DokKenLegal.fromJson(e)).toList();
  }
}
