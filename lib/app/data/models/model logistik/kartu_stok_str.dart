class KartuStokStr {
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
  int? createdAt;
  dynamic noInt;
  dynamic noEks;
  dynamic noEksNon;
  dynamic noDelpoNon;
  String? noDelpo;
  dynamic noBeli;
  dynamic noBeliNon;
  dynamic noretur;

  KartuStokStr({
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
    this.noInt,
    this.noEks,
    this.noEksNon,
    this.noDelpoNon,
    this.noDelpo,
    this.noBeli,
    this.noBeliNon,
    this.noretur,
  });

  factory KartuStokStr.fromJson(Map<String, dynamic> json) => KartuStokStr(
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
        createdAt: json['created_at'] as int?,
        noInt: json['no_int'] as dynamic,
        noEks: json['no_eks'] as dynamic,
        noEksNon: json['no_eks_non'] as dynamic,
        noDelpoNon: json['no_delpo_non'] as dynamic,
        noDelpo: json['no_delpo'] as String?,
        noBeli: json['no_beli'] as dynamic,
        noBeliNon: json['no_beli_non'] as dynamic,
        noretur: json['noretur'] as dynamic,
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
        'no_int': noInt,
        'no_eks': noEks,
        'no_eks_non': noEksNon,
        'no_delpo_non': noDelpoNon,
        'no_delpo': noDelpo,
        'no_beli': noBeli,
        'no_beli_non': noBeliNon,
        'noretur': noretur,
      };

  static List<KartuStokStr> fromJsonList(List? data) {
    return (data ?? []).map((e) => KartuStokStr.fromJson(e)).toList();
  }
}
