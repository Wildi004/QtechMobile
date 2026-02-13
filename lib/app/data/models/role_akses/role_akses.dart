import 'sub_menu.dart';

class RoleAkses {
  String? name;
  List<SubMenu>? subMenu;

  RoleAkses({this.name, this.subMenu});

  factory RoleAkses.fromJson(Map<String, dynamic> json) => RoleAkses(
        name: json['name'] as String?,
        subMenu: (json['sub_menu'] as List<dynamic>?)
            ?.map((e) => SubMenu.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'sub_menu': subMenu?.map((e) => e.toJson()).toList(),
      };

  static List<RoleAkses> fromJsonList(List? data) {
    return (data ?? []).map((e) => RoleAkses.fromJson(e)).toList();
  }
}
