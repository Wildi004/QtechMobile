class OpnameId {
  int? id;
  String? kodeMaterial;
  String? kodeStr;
  int? qty;
  String? jenisPekerjaanName;
  String? jenisMaterialName;
  String? namaMaterialName;
  String? createdByName;
  String? jmlpo;
  String? jmlpoNon;
  String? jmlpembelian;
  String? jmlpembelianNon;
  String? jmlretur;
  String? jmlsjin;
  String? jmlsjeks;
  String? jmlsjeksnon;

  OpnameId({
    this.id,
    this.kodeMaterial,
    this.kodeStr,
    this.qty,
    this.jenisPekerjaanName,
    this.jenisMaterialName,
    this.namaMaterialName,
    this.createdByName,
    this.jmlpo,
    this.jmlpoNon,
    this.jmlpembelian,
    this.jmlpembelianNon,
    this.jmlretur,
    this.jmlsjin,
    this.jmlsjeks,
    this.jmlsjeksnon,
  });

  factory OpnameId.fromJson(Map<String, dynamic> json) => OpnameId(
        id: json['id'] as int?,
        kodeMaterial: json['kode_material'] as String?,
        kodeStr: json['kode_str'] as String?,
        qty: json['qty'] as int?,
        jenisPekerjaanName: json['jenis_pekerjaan_name'] as String?,
        jenisMaterialName: json['jenis_material_name'] as String?,
        namaMaterialName: json['nama_material_name'] as String?,
        createdByName: json['created_by_name'] as String?,
        jmlpo: json['jmlpo'] as String?,
        jmlpoNon: json['jmlpo_non'] as String?,
        jmlpembelian: json['jmlpembelian'] as String?,
        jmlpembelianNon: json['jmlpembelian_non'] as String?,
        jmlretur: json['jmlretur'] as String?,
        jmlsjin: json['jmlsjin'] as String?,
        jmlsjeks: json['jmlsjeks'] as String?,
        jmlsjeksnon: json['jmlsjeksnon'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_material': kodeMaterial,
        'kode_str': kodeStr,
        'qty': qty,
        'jenis_pekerjaan_name': jenisPekerjaanName,
        'jenis_material_name': jenisMaterialName,
        'nama_material_name': namaMaterialName,
        'created_by_name': createdByName,
        'jmlpo': jmlpo,
        'jmlpo_non': jmlpoNon,
        'jmlpembelian': jmlpembelian,
        'jmlpembelian_non': jmlpembelianNon,
        'jmlretur': jmlretur,
        'jmlsjin': jmlsjin,
        'jmlsjeks': jmlsjeks,
        'jmlsjeksnon': jmlsjeksnon,
      };

  static List<OpnameId> fromJsonList(List? data) {
    return (data ?? []).map((e) => OpnameId.fromJson(e)).toList();
  }
}
