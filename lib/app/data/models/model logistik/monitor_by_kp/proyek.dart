class Proyek {
  int? id;
  String? kodeProyek;
  int? statusProyek;
  int? areaProyekId;
  int? jenisProyekId;
  int? jenisKontrakId;

  String? manFeeKantor; // "8.00"
  String? komFeeKantor; // "3"
  String? nilaiPph; // "2.65"
  String? nilaiPpn; // "12.00"

  int? potPph;
  int? sisaPotPph;
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

  int? provinsiId;
  int? vendorId;
  String? namaPemberiKerja;

  int? jumlahTotal;

  String? diskon;
  String? jmlDiskon;
  String? hargaSetelahDiskon;
  String? keuntungan;
  String? jmlKeuntungan;
  String? hargaSetelahKeuntungan;
  String? dibulatkan;

  num? ppnTotal; // bisa double dari API
  num? grandTotal; // bisa double

  int? createdBy;
  String? noHide;
  int? createdAt;
  String? keterangan;

  Proyek({
    this.id,
    this.kodeProyek,
    this.statusProyek,
    this.areaProyekId,
    this.jenisProyekId,
    this.jenisKontrakId,
    this.manFeeKantor,
    this.komFeeKantor,
    this.nilaiPph,
    this.nilaiPpn,
    this.potPph,
    this.sisaPotPph,
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
    this.provinsiId,
    this.vendorId,
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
  });

  factory Proyek.fromJson(Map<String, dynamic> json) => Proyek(
        id: _toInt(json['id']),
        kodeProyek: json['kode_proyek'] as String?,
        statusProyek: _toInt(json['status_proyek']),
        areaProyekId: _toInt(json['area_proyek_id']),
        jenisProyekId: _toInt(json['jenis_proyek_id']),
        jenisKontrakId: _toInt(json['jenis_kontrak_id']),
        manFeeKantor: json['man_fee_kantor']?.toString(),
        komFeeKantor: json['kom_fee_kantor']?.toString(),
        nilaiPph: json['nilai_pph']?.toString(),
        nilaiPpn: json['nilai_ppn']?.toString(),
        potPph: _toInt(json['pot_pph']),
        sisaPotPph: _toInt(json['sisa_pot_pph']),
        nilaiRef: _toInt(json['nilai_ref']),
        nilaiScf: _toInt(json['nilai_scf']),
        dppPendapatan: _toInt(json['dpp_pendapatan']),
        noKontrak: json['no_kontrak'] as String?,
        tglKontrak: json['tgl_kontrak'] as String?,
        judulKontrak: json['judul_kontrak'] as String?,
        nilaiKontrak: _toInt(json['nilai_kontrak']),
        durasiKontrak: json['durasi_kontrak'] as String?,
        durasiProyek: json['durasi_proyek'] as String?,
        lokasiProyek: json['lokasi_proyek'] as String?,
        provinsiId: _toInt(json['provinsi_id']),
        vendorId: _toInt(json['vendor_id']),
        namaPemberiKerja: json['nama_pemberi_kerja'] as String?,
        jumlahTotal: _toInt(json['jumlah_total']),
        diskon: json['diskon']?.toString(),
        jmlDiskon: json['jml_diskon']?.toString(),
        hargaSetelahDiskon: json['harga_setelah_diskon']?.toString(),
        keuntungan: json['keuntungan']?.toString(),
        jmlKeuntungan: json['jml_keuntungan']?.toString(),
        hargaSetelahKeuntungan: json['harga_setelah_keuntungan']?.toString(),
        dibulatkan: json['dibulatkan']?.toString(),
        ppnTotal: _toNum(json['ppn_total']),
        grandTotal: _toNum(json['grand_total']),
        createdBy: _toInt(json['created_by']),
        noHide: json['no_hide'] as String?,
        createdAt: _toInt(json['created_at']),
        keterangan: json['keterangan'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_proyek': kodeProyek,
        'status_proyek': statusProyek,
        'area_proyek_id': areaProyekId,
        'jenis_proyek_id': jenisProyekId,
        'jenis_kontrak_id': jenisKontrakId,
        'man_fee_kantor': manFeeKantor,
        'kom_fee_kantor': komFeeKantor,
        'nilai_pph': nilaiPph,
        'nilai_ppn': nilaiPpn,
        'pot_pph': potPph,
        'sisa_pot_pph': sisaPotPph,
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
        'provinsi_id': provinsiId,
        'vendor_id': vendorId,
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
      };

  // ========= HELPER AMAN UNTUK INT/DOUBLE/STRING =========
  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString());
  }

  static num? _toNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    return num.tryParse(value.toString());
  }
}
