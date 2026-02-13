class MenuAkses {
  int? id;
  String? menu;
  String? icons;
  int? urutan;
  int? kelompok;

  MenuAkses({this.id, this.menu, this.icons, this.urutan, this.kelompok});

  factory MenuAkses.fromJson(Map<String, dynamic> json) => MenuAkses(
        id: json['id'] as int?,
        menu: json['menu'] as String?,
        icons: json['icons'] as String?,
        urutan: json['urutan'] as int?,
        kelompok: json['kelompok'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'menu': menu,
        'icons': icons,
        'urutan': urutan,
        'kelompok': kelompok,
      };
  
  static List<MenuAkses> fromJsonList(List? data) {
    return (data ?? []).map((e) => MenuAkses.fromJson(e)).toList();
  }
}