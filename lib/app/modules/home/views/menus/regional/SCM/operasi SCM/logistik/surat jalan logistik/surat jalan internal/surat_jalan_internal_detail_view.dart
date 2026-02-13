import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/surat_jalan_internal/surat_jalan_internal.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Surat%20Jalan%20Logistik/surat%20jalan%20internal/surat_jalan_internal_detail_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class SuratJalanInternalDetailView
    extends GetView<SuratJalanInternalDetailController> {
  final SuratJalanInternal? data;
  final bool showPrintButton;
  final String? noInt;

  const SuratJalanInternalDetailView({
    super.key,
    this.data,
    this.showPrintButton = false,
    this.noInt,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(SuratJalanInternalDetailController());

    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.data = data;
      final datas = data!.toJson();

      forms.fill(datas);

      if (controller.formDetails.isEmpty) {
        controller.getDetails(data!);
      }
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Detail Surat Jalan Internal',
          actions: [
            // IconButton(
            //   onPressed: () {
            //     final cetakController = Get.put(CetakPoPpn());
            //     cetakController.getDataCetak(data!.noHide);
            //   },
            //   icon: Icon(Hi.printer),
            // ),

            IconButton(
              onPressed: showCustomCupertinoStyleDialog,
              icon: const Icon(Hi.alertCircle),
            ),
          ],
        ).appBar,
        body: Obx(() {
          if (controller.isLoading.value) {
            return CustomLoading();
          }

          return Column(
            children: [
              Expanded(
                child: LzListView(
                  gap: 10,
                  children: [
                    LzForm.input(
                      label: 'kode Proyek',
                      enabled: false,
                      model: forms.key('kode_proyek'),
                    ),
                    LzForm.input(
                      label: 'No. Bukti',
                      enabled: false,
                      model: forms.key('no_bukti'),
                    ),
                    LzForm.input(
                      label: 'No. Pengajuan',
                      enabled: false,
                      model: forms.key('no_pengajuan'),
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Ditujukan',
                          enabled: false,
                          model: forms.key('ditujukan'),
                        ),
                        LzForm.input(
                          label: 'Tanggal',
                          enabled: false,
                          model: forms.key('tgl'),
                        ),
                      ],
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Tujuan',
                          enabled: false,
                          model: forms.key('tujuan'),
                        ),
                      ],
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Nama Proyek',
                          enabled: false,
                          maxLines: 9,
                          model: forms.key('nama_proyek'),
                        ),
                      ],
                    ),
                    ...List.generate(controller.formDetails.length, (i) {
                      final form = controller.formDetails[i];

                      return LzCard(
                        gap: 10,
                        padding: Ei.all(10),
                        children: [
                          Text(
                            'No ${i + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          LzForm.input(
                            enabled: false,
                            label: 'Kode Material',
                            maxLines: 4,
                            model: form.key('kode_material'),
                          ),
                          Intrinsic(
                            gap: 10,
                            children: [
                              LzForm.input(
                                enabled: false,
                                label: 'Nama Barang',
                                model: form.key('nama_barang'),
                              ),
                            ],
                          ),
                          Intrinsic(
                            gap: 10,
                            children: [
                              LzForm.input(
                                enabled: false,
                                label: 'Volume',
                                model: form.key('volume'),
                              ),
                              LzForm.input(
                                enabled: false,
                                label: 'Satuan',
                                model: form.key('satuan'),
                              ),
                            ],
                          ),
                          LzForm.input(
                            enabled: false,
                            label: 'Uraian',
                            model: form.key('uraian'),
                          ),
                          LzForm.input(
                            enabled: false,
                            label: 'Total Harga',
                            model: form.key('total_harga'),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

void showCustomCupertinoStyleDialog() {
  Get.dialog(
    Dialog(
      backgroundColor:
          const Color.fromARGB(255, 255, 255, 255), // warna background custom
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Perhatian',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '1. Surat Jalan ini merupakan bukti resmi penerimaan Barang.',
              textAlign: TextAlign.center,
            ),
            Text(
              '2. Surat Jalan ini merupakan lampiran bukti penjualan.',
              textAlign: TextAlign.center,
            ),
            Text(
              '3. Surat Jalan ini akan dilengkapi Invoice & Kwitansi sebagai bukti penjualan yang sah.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    ),
  );
}
