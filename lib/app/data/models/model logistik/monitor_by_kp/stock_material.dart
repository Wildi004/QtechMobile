class StockMaterial {
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
  int? createdBy;
  int? createdAt;
  String? jenisPekerjaan;
  String? jenisMaterial;
  String? namaMaterial;
  String? namaPerusahaan;
  String? name;
  String? ttd;

  StockMaterial({
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
    this.createdBy,
    this.createdAt,
    this.jenisPekerjaan,
    this.jenisMaterial,
    this.namaMaterial,
    this.namaPerusahaan,
    this.name,
    this.ttd,
  });

  factory StockMaterial.fromJson(Map<String, dynamic> json) => StockMaterial(
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
        createdBy: json['created_by'] as int?,
        createdAt: json['created_at'] as int?,
        jenisPekerjaan: json['jenis_pekerjaan'] as String?,
        jenisMaterial: json['jenis_material'] as String?,
        namaMaterial: json['nama_material'] as String?,
        namaPerusahaan: json['nama_perusahaan'] as String?,
        name: json['name'] as String?,
        ttd: json['ttd'] as String?,
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
        'created_by': createdBy,
        'created_at': createdAt,
        'jenis_pekerjaan': jenisPekerjaan,
        'jenis_material': jenisMaterial,
        'nama_material': namaMaterial,
        'nama_perusahaan': namaPerusahaan,
        'name': name,
        'ttd': ttd,
      };
}
