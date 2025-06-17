class Building {
  int? buildingId;
  String? code;
  String? name;
  String? address;
  String? latitudeLongtitude;
  int? radius;

  Building({
    this.buildingId,
    this.code,
    this.name,
    this.address,
    this.latitudeLongtitude,
    this.radius,
  });

  factory Building.fromJson(Map<String, dynamic> json) => Building(
        buildingId: json['building_id'] as int?,
        code: json['code'] as String?,
        name: json['name'] as String?,
        address: json['address'] as String?,
        latitudeLongtitude: json['latitude_longtitude'] as String?,
        radius: json['radius'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'building_id': buildingId,
        'code': code,
        'name': name,
        'address': address,
        'latitude_longtitude': latitudeLongtitude,
        'radius': radius,
      };

  static List<Building> fromJsonList(List? data) {
    return (data ?? []).map((e) => Building.fromJson(e)).toList();
  }
}
