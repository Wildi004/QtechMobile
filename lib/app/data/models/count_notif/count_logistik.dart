class LogistikCount {
  int? alatProyekBali;
  int? alatProyekJakarta;
  int? deliveryMaterialPembelianNonPpn;
  int? deliveryMaterialPembelianPpn;
  int? deliveryMaterialPoNonPpn;
  int? deliveryMaterialPoPpn;
  int? invDeliveryMaterialPembelianNonPpn;
  int? invDeliveryMaterialPembelianPpn;
  int? invDeliveryMaterialPoNonPpn;
  int? invDeliveryMaterialPoPpn;
  int? pembelianPpn;
  int? poNonPpn;
  int? poPpn;
  int? returMaterialProyek;
  int? suratJalanEksternalBali;
  int? suratJalanEksternalJakarta;
  int? suratJalanEksternalNonPpnBali;
  int? suratJalanEksternalNonPpnJakarta;
  int? suratJalanInternalBali;
  int? suratJalanInternalJakarta;
  int? total;

  LogistikCount({
    this.alatProyekBali,
    this.alatProyekJakarta,
    this.deliveryMaterialPembelianNonPpn,
    this.deliveryMaterialPembelianPpn,
    this.deliveryMaterialPoNonPpn,
    this.deliveryMaterialPoPpn,
    this.invDeliveryMaterialPembelianNonPpn,
    this.invDeliveryMaterialPembelianPpn,
    this.invDeliveryMaterialPoNonPpn,
    this.invDeliveryMaterialPoPpn,
    this.pembelianPpn,
    this.poNonPpn,
    this.poPpn,
    this.returMaterialProyek,
    this.suratJalanEksternalBali,
    this.suratJalanEksternalJakarta,
    this.suratJalanEksternalNonPpnBali,
    this.suratJalanEksternalNonPpnJakarta,
    this.suratJalanInternalBali,
    this.suratJalanInternalJakarta,
    this.total,
  });

  factory LogistikCount.fromJson(Map<String, dynamic> json) => LogistikCount(
        alatProyekBali: json['alat_proyek_bali'],
        alatProyekJakarta: json['alat_proyek_jakarta'],
        deliveryMaterialPembelianNonPpn:
            json['delivery_material_pembelian_non_ppn'],
        deliveryMaterialPembelianPpn: json['delivery_material_pembelian_ppn'],
        deliveryMaterialPoNonPpn: json['delivery_material_po_non_ppn'],
        deliveryMaterialPoPpn: json['delivery_material_po_ppn'],
        invDeliveryMaterialPembelianNonPpn:
            json['inv_delivery_material_pembelian_non_ppn'],
        invDeliveryMaterialPembelianPpn:
            json['inv_delivery_material_pembelian_ppn'],
        invDeliveryMaterialPoNonPpn: json['inv_delivery_material_po_non_ppn'],
        invDeliveryMaterialPoPpn: json['inv_delivery_material_po_ppn'],
        pembelianPpn: json['pembelian_ppn'],
        poNonPpn: json['po_non_ppn'],
        poPpn: json['po_ppn'],
        returMaterialProyek: json['retur_material_proyek'],
        suratJalanEksternalBali: json['surat_jalan_eksternal_bali'],
        suratJalanEksternalJakarta: json['surat_jalan_eksternal_jakarta'],
        suratJalanEksternalNonPpnBali:
            json['surat_jalan_eksternal_non_ppn_bali'],
        suratJalanEksternalNonPpnJakarta:
            json['surat_jalan_eksternal_non_ppn_jakarta'],
        suratJalanInternalBali: json['surat_jalan_internal_bali'],
        suratJalanInternalJakarta: json['surat_jalan_internal_jakarta'],
        total: json['total'],
      );

  Map<String, dynamic> toJson() => {
        'alat_proyek_bali': alatProyekBali,
        'alat_proyek_jakarta': alatProyekJakarta,
        'delivery_material_pembelian_non_ppn': deliveryMaterialPembelianNonPpn,
        'delivery_material_pembelian_ppn': deliveryMaterialPembelianPpn,
        'delivery_material_po_non_ppn': deliveryMaterialPoNonPpn,
        'delivery_material_po_ppn': deliveryMaterialPoPpn,
        'inv_delivery_material_pembelian_non_ppn':
            invDeliveryMaterialPembelianNonPpn,
        'inv_delivery_material_pembelian_ppn': invDeliveryMaterialPembelianPpn,
        'inv_delivery_material_po_non_ppn': invDeliveryMaterialPoNonPpn,
        'inv_delivery_material_po_ppn': invDeliveryMaterialPoPpn,
        'pembelian_ppn': pembelianPpn,
        'po_non_ppn': poNonPpn,
        'po_ppn': poPpn,
        'retur_material_proyek': returMaterialProyek,
        'surat_jalan_eksternal_bali': suratJalanEksternalBali,
        'surat_jalan_eksternal_jakarta': suratJalanEksternalJakarta,
        'surat_jalan_eksternal_non_ppn_bali': suratJalanEksternalNonPpnBali,
        'surat_jalan_eksternal_non_ppn_jakarta':
            suratJalanEksternalNonPpnJakarta,
        'surat_jalan_internal_bali': suratJalanInternalBali,
        'surat_jalan_internal_jakarta': suratJalanInternalJakarta,
        'total': total,
      };
}
