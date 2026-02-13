import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/proyek_item/data_proyek_item.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class PekerjaanMonitoringView extends StatelessWidget {
  final List<DataProyekItem> items;

  const PekerjaanMonitoringView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Data Pekerjaan").appBar,
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.pmName ?? "-",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(item.uraianPekerjaan ?? "-",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text("Volume: ${item.volume} ${item.satuan ?? ''}"),
                Text(
                    "Harga Satuan: ${formatRupiah(int.tryParse(item.hargaSatuan ?? '0'))}"),
                Text(
                    "Jumlah Harga: ${formatRupiah(int.tryParse(item.jmlHarga ?? '0'))}"),
              ],
            ),
          );
        },
      ),
    );
  }
}

String formatRupiah(num? number) {
  if (number == null) return "-";
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  return formatter.format(number);
}
