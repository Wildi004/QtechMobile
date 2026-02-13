import 'menu.dart';

class AksesMenu {
  int? id;
  int? roleId;
  int? menuId;
  List<Menu>? menu;
  String? role;

  AksesMenu({this.id, this.roleId, this.menuId, this.menu, this.role});

  factory AksesMenu.fromJson(Map<String, dynamic> json) => AksesMenu(
        id: json['id'] as int?,
        roleId: json['role_id'] as int?,
        menuId: json['menu_id'] as int?,
        menu: (json['menu'] as List<dynamic>?)
            ?.map((e) => Menu.fromJson(e as Map<String, dynamic>))
            .toList(),
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'role_id': roleId,
        'menu_id': menuId,
        'menu': menu?.map((e) => e.toJson()).toList(),
        'role': role,
      };

  static List<AksesMenu> fromJsonList(List? data) {
    return (data ?? []).map((e) => AksesMenu.fromJson(e)).toList();
  }
}
