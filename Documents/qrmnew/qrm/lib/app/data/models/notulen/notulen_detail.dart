class NotulenDetail {
  int? id;
  String? kode;
  int? userId;
  int? role;
  String? userName;
  String? roleName;

  NotulenDetail({
    this.id,
    this.kode,
    this.userId,
    this.role,
    this.userName,
    this.roleName,
  });

  factory NotulenDetail.fromJson(Map<String, dynamic> json) => NotulenDetail(
        id: json['id'] as int?,
        kode: json['kode'] as String?,
        userId: json['user_id'] as int?,
        role: json['role'] as int?,
        userName: json['user_name'] as String?,
        roleName: json['role_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode': kode,
        'user_id': userId,
        'role': role,
        'user_name': userName,
        'role_name': roleName,
      };
}
