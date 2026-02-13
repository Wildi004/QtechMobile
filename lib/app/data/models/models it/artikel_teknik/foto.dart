class Foto {
  int? id;
  int? artikelId;
  String? file;
  String? keterangan;

  Foto({this.id, this.artikelId, this.file, this.keterangan});

  factory Foto.fromJson(Map<String, dynamic> json) => Foto(
        id: json['id'] as int?,
        artikelId: json['artikel_id'] as int?,
        file: json['file'] as String?,
        keterangan: json['keterangan'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'artikel_id': artikelId,
        'file': file,
        'keterangan': keterangan,
      };
}
