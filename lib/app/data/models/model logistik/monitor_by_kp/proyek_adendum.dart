class ProyekAdendum {
  int? id;
  String? kodeProyek;
  String? kodeProyekAdendum;
  int? statusProyekAdendum;
  int? areaProyekAdendum;
  int? jenisProyekAdendum;
  int? jenisKontrakAdendum;
  String? manFeeKantorAdendum;
  int? komFeeAdendum;
  int? nilaiPphAdendum;
  int? potPphAdendum;
  int? sisaPotPphAdendum;
  double? nilaiPpnAdendum;
  int? nilaiRefAdendum;
  int? nilaiScfAdendum;
  int? dppPendapatanAdendum;
  String? noKontrakAdendum;
  String? tglKontrakAdendum;
  String? judulKontrakAdendum;
  String? nilaiKontrakAdendum;
  String? durasiKontrakAdendum;
  String? durasiProyekAdendum;
  String? lokasiProyekAdendum;
  int? provinsiAdendum;
  int? vendorAdendum;
  String? pemeberiKerjaAdendum;
  double? jumlahTotalAdendum;
  String? diskonAdendum;
  String? jmlDiskonAdendum;
  String? hargaSetelahDiskonAdendum;
  String? keuntunganAdendum;
  String? jmlKeuntunganAdendum;
  String? hargaSetelahKeuntunganAdendum;
  String? dibulatkanAdendum;
  int? ppnTotalAdendum;
  int? grandTotalAdendum;
  int? createdBy;
  String? noHide;
  int? createdAt;

  ProyekAdendum({
    this.id,
    this.kodeProyek,
    this.kodeProyekAdendum,
    this.statusProyekAdendum,
    this.areaProyekAdendum,
    this.jenisProyekAdendum,
    this.jenisKontrakAdendum,
    this.manFeeKantorAdendum,
    this.komFeeAdendum,
    this.nilaiPphAdendum,
    this.potPphAdendum,
    this.sisaPotPphAdendum,
    this.nilaiPpnAdendum,
    this.nilaiRefAdendum,
    this.nilaiScfAdendum,
    this.dppPendapatanAdendum,
    this.noKontrakAdendum,
    this.tglKontrakAdendum,
    this.judulKontrakAdendum,
    this.nilaiKontrakAdendum,
    this.durasiKontrakAdendum,
    this.durasiProyekAdendum,
    this.lokasiProyekAdendum,
    this.provinsiAdendum,
    this.vendorAdendum,
    this.pemeberiKerjaAdendum,
    this.jumlahTotalAdendum,
    this.diskonAdendum,
    this.jmlDiskonAdendum,
    this.hargaSetelahDiskonAdendum,
    this.keuntunganAdendum,
    this.jmlKeuntunganAdendum,
    this.hargaSetelahKeuntunganAdendum,
    this.dibulatkanAdendum,
    this.ppnTotalAdendum,
    this.grandTotalAdendum,
    this.createdBy,
    this.noHide,
    this.createdAt,
  });

  factory ProyekAdendum.fromJson(Map<String, dynamic> json) => ProyekAdendum(
        id: toInt(json['id']),
        kodeProyek: toStr(json['kode_proyek']),
        kodeProyekAdendum: toStr(json['kode_proyek_adendum']),
        statusProyekAdendum: toInt(json['status_proyek_adendum']),
        areaProyekAdendum: toInt(json['area_proyek_adendum']),
        jenisProyekAdendum: toInt(json['jenis_proyek_adendum']),
        jenisKontrakAdendum: toInt(json['jenis_kontrak_adendum']),
        manFeeKantorAdendum: toStr(json['man_fee_kantor_adendum']),
        komFeeAdendum: toInt(json['kom_fee_adendum']),
        nilaiPphAdendum: toInt(json['nilai_pph_adendum']),
        potPphAdendum: toInt(json['pot_pph_adendum']),
        sisaPotPphAdendum: toInt(json['sisa_pot_pph_adendum']),
        nilaiPpnAdendum: toDouble(json['nilai_ppn_adendum']),
        nilaiRefAdendum: toInt(json['nilai_ref_adendum']),
        nilaiScfAdendum: toInt(json['nilai_scf_adendum']),
        dppPendapatanAdendum: toInt(json['dpp_pendapatan_adendum']),
        noKontrakAdendum: toStr(json['no_kontrak_adendum']),
        tglKontrakAdendum: toStr(json['tgl_kontrak_adendum']),
        judulKontrakAdendum: toStr(json['judul_kontrak_adendum']),
        nilaiKontrakAdendum: toStr(json['nilai_kontrak_adendum']),
        durasiKontrakAdendum: toStr(json['durasi_kontrak_adendum']),
        durasiProyekAdendum: toStr(json['durasi_proyek_adendum']),
        lokasiProyekAdendum: toStr(json['lokasi_proyek_adendum']),
        provinsiAdendum: toInt(json['provinsi_adendum']),
        vendorAdendum: toInt(json['vendor_adendum']),
        pemeberiKerjaAdendum: toStr(json['pemeberi_kerja_adendum']),
        jumlahTotalAdendum: toDouble(json['jumlah_total_adendum']),
        diskonAdendum: toStr(json['diskon_adendum']),
        jmlDiskonAdendum: toStr(json['jml_diskon_adendum']),
        hargaSetelahDiskonAdendum: toStr(json['harga_setelah_diskon_adendum']),
        keuntunganAdendum: toStr(json['keuntungan_adendum']),
        jmlKeuntunganAdendum: toStr(json['jml_keuntungan_adendum']),
        hargaSetelahKeuntunganAdendum:
            toStr(json['harga_setelah_keuntungan_adendum']),
        dibulatkanAdendum: toStr(json['dibulatkan_adendum']),
        ppnTotalAdendum: toInt(json['ppn_total_adendum']),
        grandTotalAdendum: toInt(json['grand_total_adendum']),
        createdBy: toInt(json['created_by']),
        noHide: toStr(json['no_hide']),
        createdAt: toInt(json['created_at']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_proyek': kodeProyek,
        'kode_proyek_adendum': kodeProyekAdendum,
        'status_proyek_adendum': statusProyekAdendum,
        'area_proyek_adendum': areaProyekAdendum,
        'jenis_proyek_adendum': jenisProyekAdendum,
        'jenis_kontrak_adendum': jenisKontrakAdendum,
        'man_fee_kantor_adendum': manFeeKantorAdendum,
        'kom_fee_adendum': komFeeAdendum,
        'nilai_pph_adendum': nilaiPphAdendum,
        'pot_pph_adendum': potPphAdendum,
        'sisa_pot_pph_adendum': sisaPotPphAdendum,
        'nilai_ppn_adendum': nilaiPpnAdendum,
        'nilai_ref_adendum': nilaiRefAdendum,
        'nilai_scf_adendum': nilaiScfAdendum,
        'dpp_pendapatan_adendum': dppPendapatanAdendum,
        'no_kontrak_adendum': noKontrakAdendum,
        'tgl_kontrak_adendum': tglKontrakAdendum,
        'judul_kontrak_adendum': judulKontrakAdendum,
        'nilai_kontrak_adendum': nilaiKontrakAdendum,
        'durasi_kontrak_adendum': durasiKontrakAdendum,
        'durasi_proyek_adendum': durasiProyekAdendum,
        'lokasi_proyek_adendum': lokasiProyekAdendum,
        'provinsi_adendum': provinsiAdendum,
        'vendor_adendum': vendorAdendum,
        'pemeberi_kerja_adendum': pemeberiKerjaAdendum,
        'jumlah_total_adendum': jumlahTotalAdendum,
        'diskon_adendum': diskonAdendum,
        'jml_diskon_adendum': jmlDiskonAdendum,
        'harga_setelah_diskon_adendum': hargaSetelahDiskonAdendum,
        'keuntungan_adendum': keuntunganAdendum,
        'jml_keuntungan_adendum': jmlKeuntunganAdendum,
        'harga_setelah_keuntungan_adendum': hargaSetelahKeuntunganAdendum,
        'dibulatkan_adendum': dibulatkanAdendum,
        'ppn_total_adendum': ppnTotalAdendum,
        'grand_total_adendum': grandTotalAdendum,
        'created_by': createdBy,
        'no_hide': noHide,
        'created_at': createdAt,
      };
}

/// ========================
/// PARSER AMAN UNTUK API
/// ========================

int? toInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) {
    return int.tryParse(value.replaceAll('.', '').replaceAll(',', ''));
  }
  return null;
}

double? toDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) {
    return double.tryParse(value.replaceAll('.', '').replaceAll(',', ''));
  }
  return null;
}

String? toStr(dynamic value) {
  if (value == null) return null;
  return value.toString();
}
