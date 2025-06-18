class UserLogin {
  int? id;
  String? email;
  String? name;
  String? token;
  String? role;
  String? dept;
  int? deptId;

  UserLogin(
      {this.id,
      this.email,
      this.name,
      this.token,
      this.role,
      this.dept,
      this.deptId});

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        id: json['id'] as int?,
        email: json['email'] as String?,
        name: json['name'] as String?,
        token: json['token'] as String?,
        role: json['role'] as String?,
        dept: json['dept'] as String?,
        deptId: json['dept_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'token': token,
        'role': role,
        'dept': dept,
        'dept_id': deptId,
      };
}
