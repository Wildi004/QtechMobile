class NotulenRole {
  int? id;
  String? role;

  NotulenRole({this.id, this.role});

  factory NotulenRole.fromJson(Map<String, dynamic> json) => NotulenRole(
        id: json['id'] as int?,
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role,
      };

  static List<NotulenRole> fromJsonList(List? data) {
    return (data ?? []).map((e) => NotulenRole.fromJson(e)).toList();
  }
}
