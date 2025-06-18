import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/pengajuan_hrd/pengajuan_hrd.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_pengajuan_controller/pengajuan_hrd_controller.dart';
import 'package:qrm/app/widgets/custom_appbar_widget.dart';

class DetailPengajuanHrdView extends GetView<PengajuanHrdController> {
  final PengajuanHrd? data;

  const DetailPengajuanHrdView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PengajuanHrdController()..data = data);
    String formatRupiah(num? value) {
      if (value == null) return '-';
      return NumberFormat.currency(
              locale: 'id', symbol: 'Rp ', decimalDigits: 0)
          .format(value);
    }

    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.getDetails(data!);
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: CustomAppbar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Hi.tick04))],
        title: 'Detail Pengajuan',
      ).appBar,
      body: Obx(() {
        bool loading = controller.isLoading.value;

        if (loading) {
          return LzLoader.bar();
        }

        return Column(
          children: [
            Container(
              padding: Ei.all(20),
              decoration: BoxDecoration(border: Br.only(['b'])),
              child: Column(
                spacing: 25,
                children: [
                  LzForm.input(
                    label: 'No. Pengajuan',
                    enabled: false,
                    model: forms.key('no_pengajuan'),
                  ),
                  Intrinsic(
                    gap: 10,
                    children: [
                      LzForm.input(
                        label: 'Tanggal Pengajuan',
                        enabled: false,
                        model: forms.key('tgl_pengajuan'),
                      ),
                      LzForm.input(
                        label: 'Departemen',
                        enabled: false,
                        model: forms.key('dep_name'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Konten scroll
            Expanded(
              child: Obx(() => LzListView(
                    gap: 10,
                    children: controller.cards.generate((e, i) {
                      return LzCard(
                        gap: 10,
                        children: [
                          buildTextField('Jenis RAB',
                              e.jenisRab ?? 'User tidak memiloh jenis RAB'),
                          buildTextField('Nama Barang', e.namaBarang ?? '-'),
                          Row(
                            children: [
                              Expanded(
                                child: buildTextField('Jumlah',
                                    e.qty != null ? e.qty.toString() : '-'),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: buildTextField(
                                    'Harga', formatRupiah(e.harga)),
                              ),
                            ],
                          ),
                          buildTextField('Total', formatRupiah(e.totalHarga)),
                          buildTextField(
                              'Total',
                              e.totalHarga != null
                                  ? e.totalHarga.toString()
                                  : '-'),
                        ],
                      ).margin(b: 15);
                    }),
                  )),
            ),
            // Grantotal (tidak scroll, posisi di bawah)
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Pengajuan dana :',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(formatRupiah(data!.subTotal))
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildTextField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(value),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
