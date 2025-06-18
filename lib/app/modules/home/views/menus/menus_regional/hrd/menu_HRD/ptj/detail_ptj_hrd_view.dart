import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/models/ptj_hrd/ptj_hrd.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_ptj_controller/detail_ptj_hrd_controller.dart';
import 'package:qrm/app/widgets/custom_appbar_widget.dart';

class DetailPtjHrdView extends GetView<DetailPtjHrdController> {
  final PtjHrd? data;

  const DetailPtjHrdView({super.key, this.data});
  String statusToText(int? status) {
    switch (status) {
      case 0:
        return 'Ditolak';
      case 1:
        return 'Belum Validasi';
      case 2:
        return 'Sudah Validasi';
      case 3:
        return 'Waiting';
      case 4:
        return 'On Progres';
      default:
        return 'Not Check';
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DetailPtjHrdController()..data = data);
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
        title: 'Detail ptj',
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
                spacing: 16,
                children: [
                  LzForm.input(
                    label: 'No. PTJ',
                    enabled: false,
                    model: forms.key('no_ptj'),
                  ),
                  Intrinsic(
                    gap: 10,
                    children: [
                      LzForm.input(
                        label: 'Tanggal PTJ',
                        enabled: false,
                        model: forms.key('tgl_ptj'),
                      ),
                      LzForm.input(
                        label: 'Departemen',
                        enabled: false,
                        model: forms.key('dep_name'),
                      ),
                    ],
                  ),
                  LzForm.input(
                    label: 'Saldo',
                    enabled: false,
                    model: forms.key('saldo'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() => LzListView(
                    gap: 10,
                    children: [
                      ...controller.cards.generate((e, i) {
                        return LzCard(
                          gap: 10,
                          children: [
                            buildTextField('Item yang dibelanjakan',
                                e.namaBarang ?? 'User tidak memilih item'),
                            Row(
                              children: [
                                Expanded(
                                  child: buildTextField(
                                      'Tanggal beli',
                                      e.tglBeli != null
                                          ? e.tglBeli.toString()
                                          : '-'),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: buildBuktiNotaField(
                                      'Bukti Nota', e.image, controller),
                                ),
                              ],
                            ),
                            buildTextField('Jumlah',
                                e.qty != null ? e.qty.toString() : '-'),
                            buildTextField(
                              'Harga satuan',
                              e.hargaSatuan != null
                                  ? formatRupiah(
                                      int.tryParse(e.hargaSatuan!) ?? 0)
                                  : '-',
                            ),
                            buildTextField(
                              'Total',
                              e.totalHarga != null
                                  ? formatRupiah(
                                      int.tryParse(e.totalHarga!) ?? 0)
                                  : '-',
                            ),
                          ],
                        ).margin(b: 15);
                      }),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status Validasi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Dir BSD',
                                style: TextStyle(fontSize: 14),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black), // Garis sisi hitam
                                  borderRadius: BorderRadius.circular(
                                      4), // Opsional, biar ada radius sudut
                                ),
                                child: Text(
                                  statusToText(data?.statusGmBsd),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Dir. Keuangan',
                                style: TextStyle(fontSize: 14),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black), // Garis sisi hitam
                                  borderRadius:
                                      BorderRadius.circular(4), // Opsional
                                ),
                                child: Text(
                                  statusToText(data?.statusDirKeuangan),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )),
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

Widget buildBuktiNotaField(String label, String? fileName, controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                fileName ?? '-',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (fileName != null)
              IconButton(
                icon: Icon(Icons.remove_red_eye),
                onPressed: () {
                  controller.openFileWithToken(fileName);
                },
              ),
          ],
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}
