class Item {
  int? id;
  String? kodeMaterial;
  String? namaMaterialName;
  String? brand;
  int? qty;

  Item({
    this.id,
    this.kodeMaterial,
    this.namaMaterialName,
    this.brand,
    this.qty,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'] as int?,
        kodeMaterial: json['kode_material'] as String?,
        namaMaterialName: json['nama_material_name'] as String?,
        brand: json['brand'] as String?,
        qty: json['qty'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_material': kodeMaterial,
        'nama_material_name': namaMaterialName,
        'brand': brand,
        'qty': qty,
      };
}
