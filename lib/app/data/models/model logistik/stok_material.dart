class StokMaterial {
  int? id;
  String? kodeMaterial;
  String? kodeStr;
  int? jenispekerjaanId;
  int? jenismaterialId;
  int? namamaterialId;
  int? suplierId;
  String? brand;
  int? qty;
  String? hargaBeli;
  String? ongkir;
  String? hargaModal;
  String? totalModal;
  int? createdAt;
  String? jenisPekerjaanName;
  String? jenisMaterialName;
  String? namaMaterialName;
  String? createdByName;

  StokMaterial({
    this.id,
    this.kodeMaterial,
    this.kodeStr,
    this.jenispekerjaanId,
    this.jenismaterialId,
    this.namamaterialId,
    this.suplierId,
    this.brand,
    this.qty,
    this.hargaBeli,
    this.ongkir,
    this.hargaModal,
    this.totalModal,
    this.createdAt,
    this.jenisPekerjaanName,
    this.jenisMaterialName,
    this.namaMaterialName,
    this.createdByName,
  });

  factory StokMaterial.fromJson(Map<String, dynamic> json) => StokMaterial(
        id: json['id'] as int?,
        kodeMaterial: json['kode_material'] as String?,
        kodeStr: json['kode_str'] as String?,
        jenispekerjaanId: json['jenispekerjaan_id'] as int?,
        jenismaterialId: json['jenismaterial_id'] as int?,
        namamaterialId: json['namamaterial_id'] as int?,
        suplierId: json['suplier_id'] as int?,
        brand: json['brand'] as String?,
        qty: json['qty'] as int?,
        hargaBeli: json['harga_beli'] as String?,
        ongkir: json['ongkir'] as String?,
        hargaModal: json['harga_modal'] as String?,
        totalModal: json['total_modal'] as String?,
        createdAt: json['created_at'] as int?,
        jenisPekerjaanName: json['jenis_pekerjaan_name'] as String?,
        jenisMaterialName: json['jenis_material_name'] as String?,
        namaMaterialName: json['nama_material_name'] as String?,
        createdByName: json['created_by_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_material': kodeMaterial,
        'kode_str': kodeStr,
        'jenispekerjaan_id': jenispekerjaanId,
        'jenismaterial_id': jenismaterialId,
        'namamaterial_id': namamaterialId,
        'suplier_id': suplierId,
        'brand': brand,
        'qty': qty,
        'harga_beli': hargaBeli,
        'ongkir': ongkir,
        'harga_modal': hargaModal,
        'total_modal': totalModal,
        'created_at': createdAt,
        'jenis_pekerjaan_name': jenisPekerjaanName,
        'jenis_material_name': jenisMaterialName,
        'nama_material_name': namaMaterialName,
        'created_by_name': createdByName,
      };

  static List<StokMaterial> fromJsonList(List? data) {
    return (data ?? []).map((e) => StokMaterial.fromJson(e)).toList();
  }
}
