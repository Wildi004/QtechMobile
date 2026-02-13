class SubMenu {
  int? id;
  int? menuId;
  String? title;
  String? url;
  String? icon;
  int? isActive;
  String? menu;

  SubMenu({
    this.id,
    this.menuId,
    this.title,
    this.url,
    this.icon,
    this.isActive,
    this.menu,
  });

  factory SubMenu.fromJson(Map<String, dynamic> json) => SubMenu(
        id: json['id'] as int?,
        menuId: json['menu_id'] as int?,
        title: json['title'] as String?,
        url: json['url'] as String?,
        icon: json['icon'] as String?,
        isActive: json['is_active'] as int?,
        menu: json['menu'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'menu_id': menuId,
        'title': title,
        'url': url,
        'icon': icon,
        'is_active': isActive,
        'menu': menu,
      };
}
