class MaterialTerbanyak {
  String? kodeMaterial;
  String? namaBarang;
  String? totalVolume;
  MaterialTerbanyak({this.kodeMaterial, this.namaBarang, this.totalVolume});
  factory MaterialTerbanyak.fromJson(Map<String, dynamic> json) {
    return MaterialTerbanyak(
      kodeMaterial: json['kode_material'] as String?,
      namaBarang: json['nama_barang'] as String?,
      totalVolume: json['total_volume'] as String?,
    );
  }
  Map<String, dynamic> toJson() => {
        'kode_material': kodeMaterial,
        'nama_barang': namaBarang,
        'total_volume': totalVolume,
      };
}
