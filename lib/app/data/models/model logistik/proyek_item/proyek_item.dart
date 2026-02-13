import 'data_proyek_item.dart';

class ProyekItems {
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
  String? noHide;
  int? createdAt;
  String? keterangan;
  String? areaProyek;
  String? jenisProyek;
  String? jenisKontrak;
  String? provinsi;
  String? vendor;
  List<DataProyekItem>? dataProyekItem;

  ProyekItems({
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

  factory ProyekItems.fromJson(Map<String, dynamic> json) => ProyekItems(
        id: json['id'] is int
            ? json['id'] as int
            : int.tryParse(json['id'].toString()),
        kodeProyek: json['kode_proyek']?.toString(),
        statusProyek: (json['status_proyek'] as num?)?.toInt(),
        manFeeKantor: json['man_fee_kantor']?.toString(),
        komFeeKantor: json['kom_fee_kantor']?.toString(),
        nilaiPph: json['nilai_pph']?.toString(),
        potPph: (json['pot_pph'] as num?)?.toInt(),
        sisaPotPph: (json['sisa_pot_pph'] as num?)?.toInt(),
        nilaiPpn: json['nilai_ppn']?.toString(),
        nilaiRef: (json['nilai_ref'] as num?)?.toInt(),
        nilaiScf: (json['nilai_scf'] as num?)?.toInt(),
        dppPendapatan: (json['dpp_pendapatan'] as num?)?.toInt(),
        noKontrak: json['no_kontrak']?.toString(),
        tglKontrak: json['tgl_kontrak']?.toString(),
        judulKontrak: json['judul_kontrak']?.toString(),
        nilaiKontrak: (json['nilai_kontrak'] as num?)?.toInt(),
        durasiKontrak: json['durasi_kontrak']?.toString(),
        durasiProyek: json['durasi_proyek']?.toString(),
        lokasiProyek: json['lokasi_proyek']?.toString(),
        namaPemberiKerja: json['nama_pemberi_kerja']?.toString(),
        jumlahTotal: (json['jumlah_total'] as num?)?.toInt(),
        diskon: json['diskon']?.toString(),
        jmlDiskon: json['jml_diskon']?.toString(),
        hargaSetelahDiskon: json['harga_setelah_diskon']?.toString(),
        keuntungan: json['keuntungan']?.toString(),
        jmlKeuntungan: json['jml_keuntungan']?.toString(),
        hargaSetelahKeuntungan: json['harga_setelah_keuntungan']?.toString(),
        dibulatkan: json['dibulatkan']?.toString(),
        ppnTotal: (json['ppn_total'] as num?)?.toInt(),
        grandTotal: (json['grand_total'] as num?)?.toInt(),
        noHide: json['no_hide']?.toString(),
        createdAt: (json['created_at'] as num?)?.toInt(),
        keterangan: json['keterangan']?.toString(),
        areaProyek: json['area_proyek']?.toString(),
        jenisProyek: json['jenis_proyek']?.toString(),
        jenisKontrak: json['jenis_kontrak']?.toString(),
        provinsi: json['provinsi']?.toString(),
        vendor: json['vendor']?.toString(),
        dataProyekItem: (json['data_proyek_item'] as List<dynamic>?)
            ?.map((e) => DataProyekItem.fromJson(e as Map<String, dynamic>))
            .toList(),
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
        'no_hide': noHide,
        'created_at': createdAt,
        'keterangan': keterangan,
        'area_proyek': areaProyek,
        'jenis_proyek': jenisProyek,
        'jenis_kontrak': jenisKontrak,
        'provinsi': provinsi,
        'vendor': vendor,
        'data_proyek_item': dataProyekItem?.map((e) => e.toJson()).toList(),
      };
  static List<ProyekItems> fromJsonList(List? data) {
    return (data ?? []).map((e) => ProyekItems.fromJson(e)).toList();
  }
}
