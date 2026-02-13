import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Monitoring%20Material%20Proyek%20timur/monitor_proyek_timur_detail_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class MonitorProyekTimurDetailView
    extends GetView<MonitorProyekTimurDetailController> {
  const MonitorProyekTimurDetailView({super.key});

  Widget buildSingleSection({
    required String title,
    required bool hasData,
    required Widget child,
  }) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14, // <<< tambah size
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: hasData ? child : Text("Tidak ada data"),
        )
      ],
    );
  }

  Widget buildListSection<T>({
    required String title,
    required List<T>? list,
    required Widget Function(int index, T item) builder,
  }) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14, // <<< tambah size
        ),
      ),
      children: [
        if (list == null || list.isEmpty)
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text("Tidak ada data"),
          )
        else
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: List.generate(
                list.length,
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: builder(i, list[i]),
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget infoCard(List<String> items) {
    return LzCard(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.map((text) {
            // Pisahkan "Title: Value"
            final split = text.split(':');
            final title = split.first.trim();
            final value =
                split.length > 1 ? split.sublist(1).join(':').trim() : '';

            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "$title: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: value.isEmpty ? "-" : value,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  // ================================================================
  // BUILD VIEW
  // ================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Info Proyek Barat").appBar,
      body: Obx(() {
        if (controller.isLoading.value) return CustomLoading();

        final m = controller.monitor;
        if (m == null) return Center(child: Text("Data tidak ditemukan"));

        return LzListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ==============================
            //     DETAIL PROYEK
            // ==============================
            buildSingleSection(
              title: "Detail Proyek",
              hasData: m.proyek != null,
              child: Column(
                children: [
                  infoCard([
                    "Kode Proyek: ${m.proyek?.kodeProyek}",
                    "Judul Kontrak: ${m.proyek?.judulKontrak}",
                    "Status: ${m.proyek?.statusProyek}",
                    "Nilai Kontrak: ${m.proyek?.nilaiKontrak}",
                    "Lokasi: ${m.proyek?.lokasiProyek}",
                  ]),
                  SizedBox(height: 12),
                  infoCard([
                    "Kode Proyek Adendum: ${m.proyekAdendum?.kodeProyekAdendum ?? '-'}",
                    "Judul Kontrak Adendum: ${m.proyekAdendum?.judulKontrakAdendum ?? '-'}",
                    "Status Adendum: ${m.proyekAdendum?.statusProyekAdendum ?? '-'}",
                    "Nilai Kontrak Adendum: ${m.proyekAdendum?.nilaiKontrakAdendum ?? '-'}",
                    "Lokasi Adendum: ${m.proyekAdendum?.lokasiProyekAdendum ?? '-'}",
                  ]),
                ],
              ),
            ),
            Divider(),

            // ==============================
            //     RBP MATERIAL UTAMA
            // ==============================
            buildListSection(
              title: "RBP Material Utama",
              list: m.rbp,
              builder: (i, p) => infoCard([
                "No. ${i + 1}",
                "Uraian: ${p.namaMaterial ?? '-'}",
                "Jumlah: ${p.jumlahMu ?? '-'}",
                "Satuan: ${p.satuanMaterial ?? '-'}",
                "Harga Modal: ${rp(p.hargaModal)}",
                "Total: ${p.totalHargaMu ?? '-'}",
              ]),
            ),
            Divider(),

            // ==============================
            //   RBP MATERIAL UTAMA ADENDUM
            // ==============================
            buildListSection(
              title: "RBP Material Utama (Adendum)",
              list: m.rbpAdendum,
              builder: (i, p) => infoCard([
                "No. ${i + 1}",
                "Uraian: ${p.namaMaterial ?? '-'}",
                "Jumlah: ${p.jumlahMuAd ?? '-'}",
                "Satuan: ${p.satuanMaterial ?? '-'}",
                " Harga Modal: ${rp(p.hargaModalAd)}",
                "Total: ${p.totalHargaMuAd ?? '-'}",
              ]),
            ),
            Divider(),

            // ==============================
            //   PENGAJUAN MATERIAL
            // ==============================
            buildListSection(
              title: "Pengajuan Material",
              list: m.pengajuan,
              builder: (i, p) => infoCard([
                "No. ${i + 1}",
                "No Pengajuan: ${p.noPengajuan ?? '-'}",
                "Tanggal: ${p.tglPengajuan ?? '-'}",
                "Nama Barang: ${p.namaBarang ?? '-'}",
                "Qty: ${p.qty ?? '-'}",
                "Harga: ${rp(p.harga)}",
                "Total: ${rp(p.totalHarga)}",
              ]),
            ),
            Divider(),

            // ==============================
            //   PO PPN
            // ==============================
            buildListSection(
              title: "Po PPN",
              list: m.po,
              builder: (i, p) => infoCard([
                "No. ${i + 1}",
                "No Po: ${p.noPo ?? '-'}",
                "Tanggal: ${p.tglPo ?? '-'}",
                "Nama Barang: ${p.namaBarang ?? '-'}",
                "Qty: ${p.qty ?? '-'}",
                "Harga Satuan: ${rp(p.unitPrice)}",
                "Diskon: ${rp(p.diskon)}",
                "Total: ${rp(p.amount)}",
              ]),
            ),
            Divider(),

            // ==============================
            //   DATA DELIVERY MATERIAL PO
            // ==============================
            buildListSection(
              title: "Data Delivery Material PO",
              list: m.delivery,
              builder: (i, p) => infoCard([
                "No. ${i + 1}",
                "No. PO: ${p.noPo ?? '-'}",
                "No. Delivery: ${p.noDelivery ?? '-'}",
                "Tgl. Delivery: ${p.tglPo ?? '-'}",
                "Kode Material: ${p.kodeMaterial ?? '-'}",
                "Nama Barang: ${p.namaBarang ?? '-'}",
                "Qty PO: ${p.qty ?? '-'}",
                "Jumlah Keluar: ${p.jumlahKeluar ?? '-'}",
                "Berat Satuan: ${p.beratSatuan ?? '-'}",
                "Total: ${p.total ?? '-'}",
              ]),
            ),
            Divider(),

            buildListSection(
              title: "Data Inovice Material",
              list: m.invoice,
              builder: (i, p) => infoCard([
                "No. ${i + 1}",
                "No. Inv: ${p.noInvoice ?? '-'}",
                "Tgl. Inv: ${p.tglInv ?? '-'}",
                "No. PO: ${p.noPo ?? '-'}",
                "No. Delivery: ${p.noDelivery ?? '-'}",
                "Kode Material: ${p.kodeMaterial ?? '-'}",
                "Nama Barang: ${p.namaBarang ?? '-'}",
                "Qty: ${p.qty ?? '-'}",
                "Harga Satuan: ${p.hargaSatuan ?? '-'}",
                "Total Harga: ${p.totalHarga ?? '-'}",
              ]),
            ),
            Divider(),

            buildListSection(
              title: "Data Surat Jalan",
              list: m.suratJalan,
              builder: (i, p) => infoCard([
                "No. ${i + 1}",
                // "No. Surat Jalan: ${p. ?? '-'}",
                "Tgl: ${p.tgl ?? '-'}",
                "Pengajuan Material: ${p.noPengajuan ?? '-'}",
                "Di Tujukan: ${p.noPengajuan ?? '-'}",
                "Kode Material: ${p.kodeMaterial ?? '-'}",
                "Nama Barang: ${p.namaBarang ?? '-'}",
                "Volume: ${p.volume ?? '-'}",
                "Satuan: ${p.satuan ?? '-'}",
                "Harga: ${p.uraian ?? '-'}",
                "Total Harga: ${p.totalHarga ?? '-'}",
              ]),
            ),
            Divider(),

            buildListSection(
              title: "Data Sisa Material",
              list: m.sisaMaterial,
              builder: (i, p) => infoCard([
                "No. ${i + 1}",
                "PM: ${p.name ?? '-'}",
                "Kode Material: ${p.kodeMaterial ?? '-'}",
                "Brand: ${p.brand ?? '-'}",
                "Qty Sisa: ${p.sisa ?? '-'}",
                "Harga Modal: ${p.hargaModal ?? '-'}",
                "Total Harga: ${p.totalHarga ?? '-'}",
                "Kondisi: ${p.kondisi ?? '-'}",
                "Tgl. Expired: ${p.tglExpired ?? '-'}",
                "Lokasi Gudang: ${p.lokasiGudang ?? '-'}",
              ]),
            ),
            Divider(),
            buildListSection(
              title: "Rekap PO per Supplier",
              list: m.pembelianSupplier,
              builder: (i, p) => infoCard([
                "No. ${i + 1}",
                "Nama Supplier: ${p.namaPerusahaan ?? '-'}",
                "Total PO(RP): ${rp(p.totalPo)}",
              ]),
            ),
            Divider(),

            buildListSection(
              title: "Rekap Invoice per Supplier",
              list: m.supplierInvoice,
              builder: (i, p) => infoCard([
                "No. ${i + 1}",
                "Nama Supplier: ${p.namaPerusahaan ?? '-'}",
                "Nilai Invoice: ${rp(p.nilaiInvoice)}",
                "PPN: ${rp(p.ppn)}",
                "Grand Total: ${rp(p.grandtotal)}",
              ]),
            ),
            Divider(),
            buildListSection(
              title: "Gap antara PO dan Invoice per Supplier",
              list: m.gapInvoicePo,
              builder: (i, p) => infoCard([
                "No. ${i + 1}",
                "Nama Supplier: ${p.namaPerusahaan ?? '-'}",
                "total PO: ${rp(p.totalPo)}",
                "total Inv: ${rp(p.totalInvoice)}",
                "GAP (PO - Invoice): ${rp(p.gap)}",
              ]),
            ),
            Divider(),
            buildListSection(
              title: "Material Paling Banyak Digunakan Berdasarkan Surat Jalan",
              list: m.materialTerbanyak,
              builder: (i, p) => infoCard([
                "No. ${i + 1}",
                "Kode Material: ${p.kodeMaterial ?? '-'}",
                "Nama Material: ${p.namaBarang ?? '-'}",
                "Total Volume: ${p.totalVolume ?? '-'}",
              ]),
            ),
            Divider(),
          ],
        );
      }),
    );
  }
}

String rp(dynamic number) {
  if (number == null) return "-";
  try {
    final value = double.tryParse(number.toString()) ?? 0;
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(value);
  } catch (_) {
    return number.toString();
  }
}
