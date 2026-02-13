class KatRk {
  int? id;
  String? keterangan;
  String? sub;
  int? bobot;
  int? target;
  int? createdAt;
  String? role;
  String? departemen;

  KatRk({
    this.id,
    this.keterangan,
    this.sub,
    this.bobot,
    this.target,
    this.createdAt,
    this.role,
    this.departemen,
  });

  factory KatRk.fromJson(Map<String, dynamic> json) => KatRk(
        id: json['id'] as int?,
        keterangan: json['keterangan'] as String?,
        sub: json['sub'] as String?,
        bobot: json['bobot'] as int?,
        target: json['target'] as int?,
        createdAt: json['created_at'] as int?,
        role: json['role'] as String?,
        departemen: json['departemen'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'keterangan': keterangan,
        'sub': sub,
        'bobot': bobot,
        'target': target,
        'created_at': createdAt,
        'role': role,
        'departemen': departemen,
      };

  static List<KatRk> fromJsonList(List? data) {
    return (data ?? []).map((e) => KatRk.fromJson(e)).toList();
  }
}
