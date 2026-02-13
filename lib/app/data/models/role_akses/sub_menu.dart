class SubMenu {
  String? name;
  int? isActive;
  dynamic icon;
  bool isAsset;

  SubMenu({
    this.name,
    this.isActive,
    this.icon,
    this.isAsset = false,
  });

  factory SubMenu.fromJson(Map<String, dynamic> json) => SubMenu(
        name: json['name'] as String?,
        isActive: json['is_active'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'is_active': isActive,
      };
}
