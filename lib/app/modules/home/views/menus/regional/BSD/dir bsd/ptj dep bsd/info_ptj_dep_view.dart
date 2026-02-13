import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class InfoPtjDepView extends StatelessWidget {
  final FormManager forms;
  final List detail;

  const InfoPtjDepView({super.key, required this.forms, required this.detail});

  String formatRupiah(num value) {
    return "Rp ${value.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => '.',
        )}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Detail Pengajuan').appBar,
      // appBar: AppBar(
      //   title: const Text("Detail Pengajuan"),
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      // ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          LzCard(
            children: [
              LzForm.input(
                label: 'No. PTJ',
                enabled: false,
                model: forms.key('no_ptj'),
              ),
              LzForm.input(
                label: 'Tgl. PTJ',
                enabled: false,
                model: forms.key('tgl_ptj'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...detail.map((item) {
            final dialogForm =
                LzForm.make(['nama_barang', 'harga_satuan', 'total_harga']);
            dialogForm.fill({
              'nama_barang': item['nama_barang']?.toString() ?? '',
              'harga_satuan': item['harga_satuan'] != null
                  ? formatRupiah(
                      num.tryParse(item['harga_satuan'].toString()) ?? 0)
                  : '0',
              'total_harga': item['total_harga'] != null
                  ? formatRupiah(
                      num.tryParse(item['total_harga'].toString()) ?? 0)
                  : '0',
            });

            return Padding(
              padding: EdgeInsets.all(10),
              child: LzCard(
                children: [
                  LzForm.input(
                    label: 'Nama Barang',
                    enabled: false,
                    maxLines: 3,
                    model: dialogForm.key('nama_barang'),
                  ),
                  LzForm.input(
                    label: 'Harga',
                    enabled: false,
                    model: dialogForm.key('harga_satuan'),
                  ),
                  LzForm.input(
                    label: 'Total',
                    enabled: false,
                    model: dialogForm.key('total_harga'),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
