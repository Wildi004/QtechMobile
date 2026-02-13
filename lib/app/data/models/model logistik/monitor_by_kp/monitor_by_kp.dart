import 'package:qrm_dev/app/data/models/model%20logistik/monitor_by_kp/delivery_item.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/monitor_by_kp/gap_po_inv.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/monitor_by_kp/inv_item.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/monitor_by_kp/inv_sup.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/monitor_by_kp/pembelian_sup.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/monitor_by_kp/po.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/monitor_by_kp/rbp_adendum.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/monitor_by_kp/sisa_material.dart';

import 'material_terbanyak.dart';
import 'pengajuan.dart';
import 'proyek.dart';
import 'proyek_adendum.dart';
import 'rbp.dart';
import 'satuan.dart';
import 'stock_material.dart';
import 'surat_jalan.dart';

class MonitorByKp {
  Proyek? proyek;
  ProyekAdendum? proyekAdendum;
  List<Rbp>? rbp;
  List<RbpAdendum>? rbpAdendum;
  List<Satuan>? satuan;
  List<StockMaterial>? stockMaterial;
  List<Pengajuan>? pengajuan;
  List<PoItem>? po;
  List<DeliveryItem>? delivery;
  List<InvItem>? invoice;
  List<SuratJalan>? suratJalan;
  List<SisaMaterial>? sisaMaterial;
  List<PembelianSupplier>? pembelianSupplier;
  List<SupplierInvoice>? supplierInvoice;
  List<GapInvoicePo>? gapInvoicePo;
  List<MaterialTerbanyak>? materialTerbanyak;

  MonitorByKp({
    this.proyek,
    this.proyekAdendum,
    this.rbp,
    this.rbpAdendum,
    this.satuan,
    this.stockMaterial,
    this.pengajuan,
    this.po,
    this.delivery,
    this.invoice,
    this.suratJalan,
    this.sisaMaterial,
    this.pembelianSupplier,
    this.supplierInvoice,
    this.gapInvoicePo,
    this.materialTerbanyak,
  });

  factory MonitorByKp.fromJson(Map<String, dynamic> json) => MonitorByKp(
        proyek: json['proyek'] == null ? null : Proyek.fromJson(json['proyek']),
        proyekAdendum: parseSingleOrList(
          json['proyek_adendum'],
          (e) => ProyekAdendum.fromJson(e),
        ),
        rbp: parseDynamicList(
          json['rbp'],
          (e) => Rbp.fromJson(e),
        ),
        rbpAdendum: parseDynamicList(
          json['rbp_adendum'],
          (e) => RbpAdendum.fromJson(e),
        ),
        satuan: parseDynamicList(
          json['satuan'],
          (e) => Satuan.fromJson(e),
        ),
        stockMaterial: parseDynamicList(
          json['stock_material'],
          (e) => StockMaterial.fromJson(e),
        ),
        pengajuan: parseDynamicList(
          json['pengajuan'],
          (e) => Pengajuan.fromJson(e),
        ),
        po: parseDynamicList(
          json['po'],
          (e) => PoItem.fromJson(e),
        ),
        delivery: parseDynamicList(
          json['delivery'],
          (e) => DeliveryItem.fromJson(e),
        ),
        invoice: parseDynamicList(
          json['invoice'],
          (e) => InvItem.fromJson(e),
        ),
        suratJalan: parseDynamicList(
          json['surat_jalan'],
          (e) => SuratJalan.fromJson(e),
        ),
        sisaMaterial: parseDynamicList(
          json['sisa_material'],
          (e) => SisaMaterial.fromJson(e),
        ),
        pembelianSupplier: parseDynamicList(
          json['pembelian_supplier'],
          (e) => PembelianSupplier.fromJson(e),
        ),
        supplierInvoice: parseDynamicList(
          json['supplier_invoice'],
          (e) => SupplierInvoice.fromJson(e),
        ),
        gapInvoicePo: parseDynamicList(
          json['gap_invoice_po'],
          (e) => GapInvoicePo.fromJson(e),
        ),
        materialTerbanyak: parseDynamicList(
          json['material_terbanyak'],
          (e) => MaterialTerbanyak.fromJson(e),
        ),
      );

  Map<String, dynamic> toJson() => {
        'proyek': proyek?.toJson(),
        'proyek_adendum': proyekAdendum?.toJson(),
        'rbp': rbp?.map((e) => e.toJson()).toList(),
        'rbp_adendum': rbpAdendum?.map((e) => e.toJson()).toList(),
        'satuan': satuan?.map((e) => e.toJson()).toList(),
        'stock_material': stockMaterial?.map((e) => e.toJson()).toList(),
        'pengajuan': pengajuan?.map((e) => e.toJson()).toList(),
        'po': po?.map((e) => e.toJson()).toList(),
        'delivery': delivery?.map((e) => e.toJson()).toList(),
        'invoice': invoice?.map((e) => e.toJson()).toList(),
        'surat_jalan': suratJalan?.map((e) => e.toJson()).toList(),
        'sisa_material': sisaMaterial?.map((e) => e.toJson()).toList(),
        'pembelian_supplier':
            pembelianSupplier?.map((e) => e.toJson()).toList(),
        'supplier_invoice': supplierInvoice?.map((e) => e.toJson()).toList(),
        'gap_invoice_po': gapInvoicePo?.map((e) => e.toJson()).toList(),
        'material_terbanyak':
            materialTerbanyak?.map((e) => e.toJson()).toList(),
      };
}

T? parseSingleOrList<T>(
  dynamic data,
  T Function(Map<String, dynamic>) fromJson,
) {
  if (data == null) return null;

  // Jika Map → langsung parse
  if (data is Map<String, dynamic>) {
    return fromJson(data);
  }

  // Jika List → ambil item pertama (kalau ada)
  if (data is List && data.isNotEmpty && data.first is Map<String, dynamic>) {
    return fromJson(data.first as Map<String, dynamic>);
  }

  return null;
}

List<T>? parseDynamicList<T>(
  dynamic data,
  T Function(Map<String, dynamic>) fromJson,
) {
  if (data == null) return [];

  if (data is Map<String, dynamic>) {
    return [fromJson(data)];
  }

  if (data is List) {
    return data.whereType<Map<String, dynamic>>().map(fromJson).toList();
  }

  return [];
}
