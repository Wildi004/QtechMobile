class JobDesk {
  int? id;
  int? roleId;
  String? image;
  int? createdBy;
  int? createdAt;
  String? createdName;
  String? roleName;

  JobDesk({
    this.id,
    this.roleId,
    this.image,
    this.createdBy,
    this.createdAt,
    this.createdName,
    this.roleName,
  });

  factory JobDesk.fromJson(Map<String, dynamic> json) => JobDesk(
        id: json['id'] as int?,
        roleId: json['role_id'] as int?,
        image: json['image'] as String?,
        createdBy: json['created_by'] as int?,
        createdAt: json['created_at'] as int?,
        createdName: json['created_name'] as String?,
        roleName: json['role_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'role_id': roleId,
        'image': image,
        'created_by': createdBy,
        'created_at': createdAt,
        'created_name': createdName,
        'role_name': roleName,
      };

  static List<JobDesk> fromJsonList(List? data) {
    return (data ?? []).map((e) => JobDesk.fromJson(e)).toList();
  }
}
