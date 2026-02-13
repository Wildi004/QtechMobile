class AccessMenu {
  int? id;
  int? roleId;
  int? menuId;
  String? menu;
  String? role;

  AccessMenu({this.id, this.roleId, this.menuId, this.menu, this.role});

  factory AccessMenu.fromJson(Map<String, dynamic> json) => AccessMenu(
        id: json['id'] as int?,
        roleId: json['role_id'] as int?,
        menuId: json['menu_id'] as int?,
        menu: json['menu'] as String?,
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'role_id': roleId,
        'menu_id': menuId,
        'menu': menu,
        'role': role,
      };
}
