class Team {
  int? id;
  String? name;
  String? image;
  int? waiting;
  int? progres;
  int? selesai;
  int? gagal;
  int? total;
  String? periodeAwal;
  String? periodeAkhir;

  Team({
    this.id,
    this.name,
    this.image,
    this.waiting,
    this.progres,
    this.selesai,
    this.gagal,
    this.total,
    this.periodeAwal,
    this.periodeAkhir,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json['id'] as int?,
        name: json['name'] as String?,
        image: json['image'] as String?,
        waiting: json['waiting'] as int?,
        progres: json['progres'] as int?,
        selesai: json['selesai'] as int?,
        gagal: json['gagal'] as int?,
        total: json['total'] as int?,
        periodeAwal: json['periode_awal'] as String?,
        periodeAkhir: json['periode_akhir'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'waiting': waiting,
        'progres': progres,
        'selesai': selesai,
        'gagal': gagal,
        'total': total,
        'periode_awal': periodeAwal,
        'periode_akhir': periodeAkhir,
      };
}
