import 'access_menu.dart';

class RoleAkses1 {
  int? id;
  String? role;
  List<AccessMenu>? accessMenus;

  RoleAkses1({this.id, this.role, this.accessMenus});

  factory RoleAkses1.fromJson(Map<String, dynamic> json) => RoleAkses1(
        id: json['id'] as int?,
        role: json['role'] as String?,
        accessMenus: (json['access_menus'] as List<dynamic>?)
            ?.map((e) => AccessMenu.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'role': role,
        'access_menus': accessMenus?.map((e) => e.toJson()).toList(),
      };

  static List<RoleAkses1> fromJsonList(List? data) {
    return (data ?? []).map((e) => RoleAkses1.fromJson(e)).toList();
  }
}
