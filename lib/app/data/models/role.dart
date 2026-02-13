class Role {
  int? id;
  String? divison;
  String? role;

  Role({this.id, this.divison, this.role});

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json['id'] as int?,
        divison: json['divison'] as String?,
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'divison': divison,
        'role': role,
      };

  static List<Role> fromJsonList(List? data) {
    return (data ?? []).map((e) => Role.fromJson(e)).toList();
  }
}
