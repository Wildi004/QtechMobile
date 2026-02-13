class UserLogin {
  int? id;
  String? email;
  String? name;
  String? token;
  String? role;
  int? roleId;

  String? dept;
  String? building;
  int? deptId;

  UserLogin(
      {this.id,
      this.email,
      this.name,
      this.token,
      this.roleId,
      this.role,
      this.dept,
      this.building,
      this.deptId});

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        id: json['id'] as int?,
        email: json['email'] as String?,
        name: json['name'] as String?,
        token: json['token'] as String?,
        role: json['role'] as String?,
        dept: json['dept'] as String?,
        building: json['building'] as String?,
        deptId: json['dept_id'] as int?,
        roleId: json['role_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'token': token,
        'role': role,
        'dept': dept,
        'building': building,
        'dept_id': deptId,
        'role_id': roleId,
      };
}
