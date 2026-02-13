class Bonus {
  int? id;
  String? keterangan;
  int? jumlah;
  String? tglBonus;
  int? createdAt;
  String? name;

  Bonus({
    this.id,
    this.keterangan,
    this.jumlah,
    this.tglBonus,
    this.createdAt,
    this.name,
  });

  factory Bonus.fromJson(Map<String, dynamic> json) => Bonus(
        id: json['id'] as int?,
        keterangan: json['keterangan'] as String?,
        jumlah: json['jumlah'] as int?,
        tglBonus: json['tgl_bonus'] as String?,
        createdAt: json['created_at'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'keterangan': keterangan,
        'jumlah': jumlah,
        'tgl_bonus': tglBonus,
        'created_at': createdAt,
        'name': name,
      };

  static List<Bonus> fromJsonList(List? data) {
    return (data ?? []).map((e) => Bonus.fromJson(e)).toList();
  }
}
