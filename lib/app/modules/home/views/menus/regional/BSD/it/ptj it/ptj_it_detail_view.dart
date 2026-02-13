import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/ptj_it/ptj_it.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/PTJ%20IT/ptj_it_detail_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class PtjItDetailView extends GetView<PtjItDetailController> {
  final PtjIt? data;
  const PtjItDetailView({super.key, this.data});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PtjItDetailController()..data = data);
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
      controller.getDetails(data!);
      controller.getSaldo();
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: CustomAppbar(
        title: 'Detail ptj',
      ).appBar,
      body: Obx(() {
        bool loading = controller.isLoading.value;

        if (loading) {
          return CustomLoading();
        }

        return Column(
          children: [
            Container(
              padding: Ei.all(20),
              decoration: BoxDecoration(border: Br.only(['b'])),
              child: Column(
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
              child: Obx(
                () => LzListView(
                  gap: 10,
                  children: [
                    ...List.generate(controller.formDetails.length, (i) {
                      final form = controller.formDetails[i];
                      return LzCard(
                        gap: 10,
                        children: [
                          LzForm.input(
                            label: 'Nama Barang',
                            enabled: false,
                            maxLines: 99,
                            model: form.key('nama_barang'),
                          ),
                          Intrinsic(
                            gap: 10,
                            children: [
                              LzForm.input(
                                label: 'Tanggal Beli',
                                enabled: false,
                                model: form.key('tgl_beli'),
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  foregroundColor: Colors.black87,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  alignment: Alignment.centerLeft,
                                ),
                                icon: Icon(Hi.eye, color: Colors.blueGrey),
                                label: Text('Lihat Nota'),
                                onPressed: () {
                                  final imgUrl = form.get('image') ?? '';
                                  if (imgUrl.isNotEmpty) {
                                    controller
                                        .openFileWithTokenAndShowViewer(imgUrl);
                                  } else {
                                    Get.snackbar(
                                        'Info', 'Tidak ada gambar tersedia');
                                  }
                                },
                              ),
                            ],
                          ),
                          Intrinsic(
                            gap: 10,
                            children: [
                              LzForm.input(
                                label: 'Qty',
                                enabled: false,
                                model: form.key('qty'),
                              ),
                              LzForm.input(
                                label: 'Harga Satuan',
                                enabled: false,
                                model: form.key('harga_satuan'),
                              ),
                            ],
                          ),
                          LzForm.input(
                            label: 'Total',
                            enabled: false,
                            model: form.key('total_harga'),
                          ),
                          LzForm.input(
                            label: 'Komentar Direktur Utama',
                            enabled: false,
                            maxLines: 99,
                            model: form.key('komentar_dirut'),
                          ),
                          LzForm.input(
                            label: 'Komentar',
                            enabled: false,
                            maxLines: 99,
                            model: form.key('komentar'),
                          ),
                        ],
                      );
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
                        SizedBox(height: 15),
                        statusValidasiRow('Dir BSD', data?.statusGmBsd),
                        SizedBox(height: 15),
                        statusValidasiRow(
                            'Dir Keuangan', data?.statusDirKeuangan),
                      ],
                    ),
                  ],
                ),
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
                icon: const Icon(Icons.remove_red_eye),
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
