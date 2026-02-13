import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/po_ppn/po_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20logistik%20bali/validasi%20po%20ppn/form_validasi_po_ppn_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/po%20ppn/po_ppn_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class FormValidasiPoPpnView extends GetView<FormValidasiPoPpnController> {
  final PoPpn? data;
  const FormValidasiPoPpnView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormValidasiPoPpnController());
    final forms = controller.forms;

    if (data != null) {
      controller.setData(data!);
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Form Validasi PO PPN Logistik',
        actions: [
          IconButton(
            onPressed: () {
              controller.onSubmit(data?.noHide);
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
                      label: 'No PO',
                      enabled: false,
                      maxLines: 99,
                      model: controller.forms.key('no_po'),
                    ),
                  Intrinsic(
                    gap: 10,
                    children: [
                      LzForm.input(
                        label: 'Tgl Po',
                        enabled: false,
                        model: controller.forms.key('tgl_po'),
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
                        label: Text('Detail'),
                        onPressed: () {
                          if (data != null) {
                            Get.to(() => PoPpnDetailView(data: data!));
                          }
                        },
                      ),
                    ],
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
                              label: 'Satuan',
                              model: form.key('satuan_id'),
                            ),
                          ],
                        ),
                        LzForm.input(
                          label: 'Harga',
                          formatters: [Formatter.currency()],
                          hint: 'Masukkan harga',
                          model: form.key('unit_price'),
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
