import 'item.dart';

class StokOpname {
  String? jenisMaterial;
  int? id;
  List<Item>? items;

  StokOpname({this.jenisMaterial, this.id, this.items});

  factory StokOpname.fromJson(Map<String, dynamic> json) => StokOpname(
        jenisMaterial: json['jenis_material'] as String?,
        id: json['id'] as int?,
        items: (json['items'] as List<dynamic>?)
            ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'jenis_material': jenisMaterial,
        'id': id,
        'items': items?.map((e) => e.toJson()).toList(),
      };

  static List<StokOpname> fromJsonList(List? data) {
    return (data ?? []).map((e) => StokOpname.fromJson(e)).toList();
  }
}
