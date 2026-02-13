class ProyekRbp {
  int? id;
  String? kodeProyek;
  int? statusProyek;
  String? manFeeKantor;
  String? komFeeKantor;
  String? nilaiPph;
  int? potPph;
  int? sisaPotPph;
  String? nilaiPpn;
  int? nilaiRef;
  int? nilaiScf;
  int? dppPendapatan;
  String? noKontrak;
  String? tglKontrak;
  String? judulKontrak;
  int? nilaiKontrak;
  String? durasiKontrak;
  String? durasiProyek;
  String? lokasiProyek;
  String? namaPemberiKerja;
  int? jumlahTotal;
  String? diskon;
  String? jmlDiskon;
  String? hargaSetelahDiskon;
  String? keuntungan;
  String? jmlKeuntungan;
  String? hargaSetelahKeuntungan;
  String? dibulatkan;
  int? ppnTotal;
  int? grandTotal;
  int? createdBy;
  String? noHide;
  int? createdAt;
  String? keterangan;
  String? areaProyek;
  String? jenisProyek;
  String? jenisKontrak;
  String? provinsi;
  String? vendor;

  ProyekRbp({
    this.id,
    this.kodeProyek,
    this.statusProyek,
    this.manFeeKantor,
    this.komFeeKantor,
    this.nilaiPph,
    this.potPph,
    this.sisaPotPph,
    this.nilaiPpn,
    this.nilaiRef,
    this.nilaiScf,
    this.dppPendapatan,
    this.noKontrak,
    this.tglKontrak,
    this.judulKontrak,
    this.nilaiKontrak,
    this.durasiKontrak,
    this.durasiProyek,
    this.lokasiProyek,
    this.namaPemberiKerja,
    this.jumlahTotal,
    this.diskon,
    this.jmlDiskon,
    this.hargaSetelahDiskon,
    this.keuntungan,
    this.jmlKeuntungan,
    this.hargaSetelahKeuntungan,
    this.dibulatkan,
    this.ppnTotal,
    this.grandTotal,
    this.createdBy,
    this.noHide,
    this.createdAt,
    this.keterangan,
    this.areaProyek,
    this.jenisProyek,
    this.jenisKontrak,
    this.provinsi,
    this.vendor,
  });

  factory ProyekRbp.fromJson(Map<String, dynamic> json) => ProyekRbp(
        id: toInt(json['id']),
        kodeProyek: json['kode_proyek'] as String?,
        statusProyek: toInt(json['status_proyek']),
        manFeeKantor: json['man_fee_kantor'] as String?,
        komFeeKantor: json['kom_fee_kantor'] as String?,
        nilaiPph: json['nilai_pph'] as String?,
        potPph: toInt(json['pot_pph']),
        sisaPotPph: toInt(json['sisa_pot_pph']),
        nilaiPpn: json['nilai_ppn'] as String?,
        nilaiRef: toInt(json['nilai_ref']),
        nilaiScf: toInt(json['nilai_scf']),
        dppPendapatan: toInt(json['dpp_pendapatan']),
        noKontrak: json['no_kontrak'] as String?,
        tglKontrak: json['tgl_kontrak'] as String?,
        judulKontrak: json['judul_kontrak'] as String?,
        nilaiKontrak: toInt(json['nilai_kontrak']),
        durasiKontrak: json['durasi_kontrak'] as String?,
        durasiProyek: json['durasi_proyek'] as String?,
        lokasiProyek: json['lokasi_proyek'] as String?,
        namaPemberiKerja: json['nama_pemberi_kerja'] as String?,
        jumlahTotal: toInt(json['jumlah_total']),
        diskon: json['diskon'] as String?,
        jmlDiskon: json['jml_diskon'] as String?,
        hargaSetelahDiskon: json['harga_setelah_diskon'] as String?,
        keuntungan: json['keuntungan'] as String?,
        jmlKeuntungan: json['jml_keuntungan'] as String?,
        hargaSetelahKeuntungan: json['harga_setelah_keuntungan'] as String?,
        dibulatkan: json['dibulatkan'] as String?,
        ppnTotal: toInt(json['ppn_total']),
        grandTotal: toInt(json['grand_total']),
        createdBy: toInt(json['created_by']),
        noHide: json['no_hide'] as String?,
        createdAt: toInt(json['created_at']),
        keterangan: json['keterangan'] as String?,
        areaProyek: json['area_proyek'] as String?,
        jenisProyek: json['jenis_proyek'] as String?,
        jenisKontrak: json['jenis_kontrak'] as String?,
        provinsi: json['provinsi'] as String?,
        vendor: json['vendor'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_proyek': kodeProyek,
        'status_proyek': statusProyek,
        'man_fee_kantor': manFeeKantor,
        'kom_fee_kantor': komFeeKantor,
        'nilai_pph': nilaiPph,
        'pot_pph': potPph,
        'sisa_pot_pph': sisaPotPph,
        'nilai_ppn': nilaiPpn,
        'nilai_ref': nilaiRef,
        'nilai_scf': nilaiScf,
        'dpp_pendapatan': dppPendapatan,
        'no_kontrak': noKontrak,
        'tgl_kontrak': tglKontrak,
        'judul_kontrak': judulKontrak,
        'nilai_kontrak': nilaiKontrak,
        'durasi_kontrak': durasiKontrak,
        'durasi_proyek': durasiProyek,
        'lokasi_proyek': lokasiProyek,
        'nama_pemberi_kerja': namaPemberiKerja,
        'jumlah_total': jumlahTotal,
        'diskon': diskon,
        'jml_diskon': jmlDiskon,
        'harga_setelah_diskon': hargaSetelahDiskon,
        'keuntungan': keuntungan,
        'jml_keuntungan': jmlKeuntungan,
        'harga_setelah_keuntungan': hargaSetelahKeuntungan,
        'dibulatkan': dibulatkan,
        'ppn_total': ppnTotal,
        'grand_total': grandTotal,
        'created_by': createdBy,
        'no_hide': noHide,
        'created_at': createdAt,
        'keterangan': keterangan,
        'area_proyek': areaProyek,
        'jenis_proyek': jenisProyek,
        'jenis_kontrak': jenisKontrak,
        'provinsi': provinsi,
        'vendor': vendor,
      };

  static List<ProyekRbp> fromJsonList(List? data) {
    return (data ?? []).map((e) => ProyekRbp.fromJson(e)).toList();
  }
}

int? toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}
