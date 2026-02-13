import 'package:qrm_dev/app/data/models/model%20logistik/proyek_item/data_proyek_item.dart';

class Proyek {
  int? id;
  String? kodeProyek;
  int? statusProyek;
  double? manFeeKantor;
  double? komFeeKantor;
  double? nilaiPph;
  double? potPph;
  double? sisaPotPph;
  double? nilaiPpn;
  double? nilaiRef;
  double? nilaiScf;
  double? dppPendapatan;
  String? noKontrak;
  String? tglKontrak;
  String? judulKontrak;
  double? nilaiKontrak;
  String? durasiKontrak;
  String? durasiProyek;
  String? lokasiProyek;
  String? namaPemberiKerja;
  double? jumlahTotal;
  double? diskon;
  double? jmlDiskon;
  double? hargaSetelahDiskon;
  double? keuntungan;
  double? jmlKeuntungan;
  double? hargaSetelahKeuntungan;
  double? dibulatkan;
  double? ppnTotal;
  double? grandTotal;
  int? createdBy;
  String? noHide;
  int? createdAt;
  String? keterangan;
  String? areaProyek;
  String? jenisProyek;
  String? jenisKontrak;
  String? provinsi;
  String? vendor;
  List<DataProyekItem>? dataProyekItem;

  Proyek({
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
    this.dataProyekItem,
  });

  factory Proyek.fromJson(Map<String, dynamic> json) => Proyek(
        id: json['id'] as int?,
        kodeProyek: json['kode_proyek'] as String?,
        statusProyek: json['status_proyek'] as int?,
        manFeeKantor: _parseDouble(json['man_fee_kantor']),
        komFeeKantor: _parseDouble(json['kom_fee_kantor']),
        nilaiPph: _parseDouble(json['nilai_pph']),
        potPph: _parseDouble(json['pot_pph']),
        sisaPotPph: _parseDouble(json['sisa_pot_pph']),
        nilaiPpn: _parseDouble(json['nilai_ppn']),
        nilaiRef: _parseDouble(json['nilai_ref']),
        nilaiScf: _parseDouble(json['nilai_scf']),
        dppPendapatan: _parseDouble(json['dpp_pendapatan']),
        noKontrak: json['no_kontrak'] as String?,
        tglKontrak: json['tgl_kontrak'] as String?,
        judulKontrak: json['judul_kontrak'] as String?,
        nilaiKontrak: _parseDouble(json['nilai_kontrak']),
        durasiKontrak: json['durasi_kontrak'] as String?,
        durasiProyek: json['durasi_proyek'] as String?,
        lokasiProyek: json['lokasi_proyek'] as String?,
        namaPemberiKerja: json['nama_pemberi_kerja'] as String?,
        jumlahTotal: _parseDouble(json['jumlah_total']),
        diskon: _parseDouble(json['diskon']),
        jmlDiskon: _parseDouble(json['jml_diskon']),
        hargaSetelahDiskon: _parseDouble(json['harga_setelah_diskon']),
        keuntungan: _parseDouble(json['keuntungan']),
        jmlKeuntungan: _parseDouble(json['jml_keuntungan']),
        hargaSetelahKeuntungan: _parseDouble(json['harga_setelah_keuntungan']),
        dibulatkan: _parseDouble(json['dibulatkan']),
        ppnTotal: _parseDouble(json['ppn_total']),
        grandTotal: _parseDouble(json['grand_total']),
        createdBy: json['created_by'] as int?,
        noHide: json['no_hide'] as String?,
        createdAt: json['created_at'] as int?,
        keterangan: json['keterangan'] as String?,
        areaProyek: json['area_proyek'] as String?,
        jenisProyek: json['jenis_proyek'] as String?,
        jenisKontrak: json['jenis_kontrak'] as String?,
        provinsi: json['provinsi'] as String?,
        vendor: json['vendor'] as String?,
        dataProyekItem: json['data_proyek_item'] != null
            ? List<DataProyekItem>.from(
                json['data_proyek_item'].map((x) => DataProyekItem.fromJson(x)))
            : [],
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
        'data_proyek_item': dataProyekItem?.map((x) => x.toJson()).toList(),
      };

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      // hapus koma sebelum parse
      return double.tryParse(value.replaceAll(',', ''));
    }
    return null;
  }
}
