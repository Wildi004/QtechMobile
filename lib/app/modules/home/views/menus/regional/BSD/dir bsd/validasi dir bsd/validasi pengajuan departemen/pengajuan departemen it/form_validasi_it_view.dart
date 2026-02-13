import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/pengajuan_it/pengajuan_it.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20pengajuan%20departemen/form_validasi_it_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class FormValidasiItView extends GetView<FormValidasiItController> {
  final PengajuanIt? data;
  const FormValidasiItView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormValidasiItController());
    final forms = controller.forms;

    if (data != null) {
      controller.setData(data!);
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Form Validasi Pengajuan IT',
        actions: [
          IconButton(
            onPressed: () {
              controller.onSubmit(data?.id);
            },
            icon: const Icon(Hi.tick04),
          ),
        ],
      ).appBar,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CustomLoading());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Bagian Header (tetap di atas) ===
            if (controller.data != null) ...[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'No Pengajuan: ${controller.data?.noPengajuan ?? "-"}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text('Tanggal: ${controller.data?.tglPengajuan ?? "-"}'),
                    const Divider(),
                  ],
                ),
              ),
            ],

            // === Bagian Scrollable (barang + kesimpulan) ===
            Expanded(
              child: LzListView(
                gap: 16,
                children: [
                  if (controller.cards.isEmpty)
                    const Center(child: Text("Belum ada item barang"))
                  else
                    ...List.generate(controller.cards.length, (i) {
                      final form = controller.formDetails[i];
                      return LzCard(
                        gap: 10,
                        padding: Ei.all(14),
                        children: [
                          LzForm.input(
                            label: 'Nama Barang',
                            enabled: false,
                            maxLines: 99,
                            model: form.key('nama_barang'),
                          ),
                          LzForm.input(
                            label: 'Qty',
                            model: form.key('qty'),
                          ),
                          LzForm.input(
                            label: 'Harga',
                            formatters: [Formatter.currency()],
                            hint: 'Masukkan harga',
                            model: form.key('harga'),
                          ),
                          LzForm.input(
                            label: 'Komentar',
                            hint: 'Masukkan komentar',
                            model: form.key('komentar'),
                          ),
                          LzForm.radio(
                            label: 'Status Validasi',
                            options: ['Acc', 'Tolak'],
                            model: form.key('status_acc'),
                            onChange: (value) {
                              controller.onStatusAccChanged(value);
                            },
                          ),
                        ],
                      );
                    }),
                  LzForm.input(
                    label: 'Total',
                    hint: 'Total',
                    model: forms.key('sub_total'),
                  ),
                  LzForm.select(
                    label: 'Kesimpulan Validasi',
                    style: OptionPickerStyle(withSearch: true),
                    hint: 'Pilih Kesimpulan Validasi',
                    model: controller.forms.key('kesimpulan_status_validasi'),
                    onTap: () async {
                      final data = await controller.getFinal().overlay();
                      controller.forms
                          .set('kesimpulan_status_validasi')
                          .options(data.labelValue('name', 'id'));
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
