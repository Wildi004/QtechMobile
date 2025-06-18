class ModalLogistik {
  int? id;
  String? kodeMaterial;
  String? nama;
  String? tglInput;
  String? tglBerlaku;
  String? qty;
  String? satuan;
  String? hargaSatuan;
  String? hargaDiskon;
  String? ppn;
  String? totalPpn;
  String? subTotal;
  String? ongkir;
  String? hargaModal;
  String? lokasi;
  int? userId;
  int? supplier;
  String? keterangan;
  String? userName;
  String? supplierName;

  ModalLogistik({
    this.id,
    this.kodeMaterial,
    this.nama,
    this.tglInput,
    this.tglBerlaku,
    this.qty,
    this.satuan,
    this.hargaSatuan,
    this.hargaDiskon,
    this.ppn,
    this.totalPpn,
    this.subTotal,
    this.ongkir,
    this.hargaModal,
    this.lokasi,
    this.userId,
    this.supplier,
    this.keterangan,
    this.userName,
    this.supplierName,
  });

  factory ModalLogistik.fromJson(Map<String, dynamic> json) => ModalLogistik(
        id: json['id'] as int?,
        kodeMaterial: json['kode_material'] as String?,
        nama: json['nama'] as String?,
        tglInput: json['tgl_input'] as String?,
        tglBerlaku: json['tgl_berlaku'] as String?,
        qty: json['qty'] as String?,
        satuan: json['satuan'] as String?,
        hargaSatuan: json['harga_satuan'] as String?,
        hargaDiskon: json['harga_diskon'] as String?,
        ppn: json['ppn'] as String?,
        totalPpn: json['total_ppn'] as String?,
        subTotal: json['sub_total'] as String?,
        ongkir: json['ongkir'] as String?,
        hargaModal: json['harga_modal'] as String?,
        lokasi: json['lokasi'] as String?,
        userId: json['user_id'] as int?,
        supplier: json['supplier'] as int?,
        keterangan: json['keterangan'] as String?,
        userName: json['user_name'] as String?,
        supplierName: json['supplier_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_material': kodeMaterial,
        'nama': nama,
        'tgl_input': tglInput,
        'tgl_berlaku': tglBerlaku,
        'qty': qty,
        'satuan': satuan,
        'harga_satuan': hargaSatuan,
        'harga_diskon': hargaDiskon,
        'ppn': ppn,
        'total_ppn': totalPpn,
        'sub_total': subTotal,
        'ongkir': ongkir,
        'harga_modal': hargaModal,
        'lokasi': lokasi,
        'user_id': userId,
        'supplier': supplier,
        'keterangan': keterangan,
        'user_name': userName,
        'supplier_name': supplierName,
      };

  static List<ModalLogistik> fromJsonList(List? data) {
    return (data ?? []).map((e) => ModalLogistik.fromJson(e)).toList();
  }
}
