import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/ptj_it/ptj_it.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/Validasi%20PTJ/validasi%20ptj%20it/form_validasi_ptj_it_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class FormValidasiPtjItView extends GetView<FormValidasiPtjItController> {
  final PtjIt? data;
  const FormValidasiPtjItView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormValidasiPtjItController());
    final forms = controller.forms;

    if (data != null) {
      controller.setData(data!);
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Form Validasi PTJ IT',
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
            if (controller.data != null) ...[],

            Expanded(
              child: LzListView(
                gap: 16,
                children: [
                  if (controller.cards.isEmpty)
                    const Center(child: Text("Belum ada item barang"))
                  else
                    LzForm.input(
                      label: 'No PTJ',
                      enabled: false,
                      maxLines: 99,
                      model: controller.forms.key('no_ptj'),
                    ),
                  Intrinsic(
                    gap: 10,
                    children: [
                      LzForm.input(
                        label: 'Departemen',
                        enabled: false,
                        maxLines: 99,
                        model: controller.forms.key('dep_name'),
                      ),
                      LzForm.input(
                        label: 'Tanggal PTJ',
                        enabled: false,
                        maxLines: 99,
                        model: controller.forms.key('tgl_ptj'),
                      ),
                    ],
                  ),
                  LzForm.input(
                    label: 'Pemohon',
                    enabled: false,
                    maxLines: 99,
                    model: controller.forms.key('created_name'),
                  ),
                  ...List.generate(controller.cards.length, (i) {
                    final form = controller.formDetails[i];
                    return LzCard(
                      gap: 10,
                      padding: Ei.all(14),
                      children: [
                        LzForm.input(
                          label: 'Item',
                          enabled: false,
                          maxLines: 99,
                          model: form.key('nama_barang'),
                        ),
                        Intrinsic(
                          gap: 10,
                          children: [
                            LzForm.input(
                              label: 'Qty',
                              model: form.key('qty'),
                            ),
                            LzForm.input(
                              label: 'Tanggal Beli',
                              model: form.key('tgl_beli'),
                            ),
                          ],
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
                          onChange: (val) {
                            controller.onStatusAccChanged(val.toString());
                          },
                        ),
                      ],
                    );
                  }),
                  LzForm.input(
                    label: 'Total',
                    hint: 'Total',
                    model: forms.key('total'),
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
