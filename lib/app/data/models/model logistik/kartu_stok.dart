class KartuStok {
  int? id;
  String? tgl;
  String? kodeMaterial;
  String? kodeStr;
  String? noPo;
  String? noPoNon;
  String? noPembelian;
  String? noPembelianNon;
  String? noRetur;
  String? noSjInt;
  String? noSjEks;
  String? noSjEksNon;
  int? masuk;
  int? keluar;
  dynamic createdAt;
  String? kodeMaterialStok;
  String? namaMaterial;
  String? namaPerusahaan;
  String? materialBrand; // 🆕 Tambahan
  String? materialHargaModal; // 🆕 Tambahan

  KartuStok({
    this.id,
    this.tgl,
    this.kodeMaterial,
    this.kodeStr,
    this.noPo,
    this.noPoNon,
    this.noPembelian,
    this.noPembelianNon,
    this.noRetur,
    this.noSjInt,
    this.noSjEks,
    this.noSjEksNon,
    this.masuk,
    this.keluar,
    this.createdAt,
    this.kodeMaterialStok,
    this.namaMaterial,
    this.namaPerusahaan,
    this.materialBrand, // 🆕
    this.materialHargaModal, // 🆕
  });

  factory KartuStok.fromJson(Map<String, dynamic> json) => KartuStok(
        id: json['id'] as int?,
        tgl: json['tgl'] as String?,
        kodeMaterial: json['kode_material'] as String?,
        kodeStr: json['kode_str'] as String?,
        noPo: json['no_po'] as String?,
        noPoNon: json['no_po_non'] as String?,
        noPembelian: json['no_pembelian'] as String?,
        noPembelianNon: json['no_pembelian_non'] as String?,
        noRetur: json['no_retur'] as String?,
        noSjInt: json['no_sj_int'] as String?,
        noSjEks: json['no_sj_eks'] as String?,
        noSjEksNon: json['no_sj_eks_non'] as String?,
        masuk: json['masuk'] as int?,
        keluar: json['keluar'] as int?,
        createdAt: json['created_at'],
        kodeMaterialStok: json['kode_material_stok'] as String?,
        namaMaterial: json['nama_material'] as String?,
        namaPerusahaan: json['nama_perusahaan'] as String?,
        materialBrand: json['material_brand'] as String?, // 🆕
        materialHargaModal: json['material_harga_modal'] as String?, // 🆕
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'tgl': tgl,
        'kode_material': kodeMaterial,
        'kode_str': kodeStr,
        'no_po': noPo,
        'no_po_non': noPoNon,
        'no_pembelian': noPembelian,
        'no_pembelian_non': noPembelianNon,
        'no_retur': noRetur,
        'no_sj_int': noSjInt,
        'no_sj_eks': noSjEks,
        'no_sj_eks_non': noSjEksNon,
        'masuk': masuk,
        'keluar': keluar,
        'created_at': createdAt,
        'kode_material_stok': kodeMaterialStok,
        'nama_material': namaMaterial,
        'nama_perusahaan': namaPerusahaan,
        'material_brand': materialBrand,
        'material_harga_modal': materialHargaModal,
      };

  static List<KartuStok> fromJsonList(List? data) {
    return (data ?? []).map((e) => KartuStok.fromJson(e)).toList();
  }
}
