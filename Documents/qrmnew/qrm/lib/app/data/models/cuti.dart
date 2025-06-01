class Cuti {
  int? id;
  int? userId;
  int? jmlCuti;
  int? createdAt;
  String? user;

  Cuti({this.id, this.userId, this.jmlCuti, this.createdAt, this.user});

  factory Cuti.fromJson(Map<String, dynamic> json) => Cuti(
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        jmlCuti: json['jml_cuti'] as int?,
        createdAt: json['created_at'] as int?,
        user: json['user'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'jml_cuti': jmlCuti,
        'created_at': createdAt,
        'user': user,
      };

  static List<Cuti> fromJsonList(List? data) {
    return (data ?? []).map((e) => Cuti.fromJson(e)).toList();
  }
}
