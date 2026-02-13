import 'sub_menu.dart';

class Menu {
  int? id;
  String? menu;
  String? icons;
  int? urutan;
  int? kelompok;
  List<SubMenu>? subMenu;

  Menu({
    this.id,
    this.menu,
    this.icons,
    this.urutan,
    this.kelompok,
    this.subMenu,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json['id'] as int?,
        menu: json['menu'] as String?,
        icons: json['icons'] as String?,
        urutan: json['urutan'] as int?,
        kelompok: json['kelompok'] as int?,
        subMenu: (json['sub_menu'] as List<dynamic>?)
            ?.map((e) => SubMenu.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'menu': menu,
        'icons': icons,
        'urutan': urutan,
        'kelompok': kelompok,
        'sub_menu': subMenu?.map((e) => e.toJson()).toList(),
      };
}
