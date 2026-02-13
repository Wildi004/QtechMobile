import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Po%20Ppn/laporan_po_proyek_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/po%20ppn/cetak%20po%20ppn/cetak_print_po_ppn.dart';

class LaporanPoProyekView extends GetView<LaporanPoProyekController> {
  const LaporanPoProyekView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LaporanPoProyekController());
    final forms = controller.forms;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Obx(
        () => Column(
          children: [
            Expanded(
              child: LzListView(
                children: [
                  LzForm.select(
                    hint: 'Pilih',
                    label: 'Filter Berdasarkan',
                    model: forms.key('filter_berdasarkan'),
                    onTap: () async {
                      final data = await controller.getFilter().overlay();
                      forms
                          .set('filter_berdasarkan')
                          .options(data.labelValue('name'));
                    },
                    onChange: (val) => controller.onChangeFilter(val),
                  ),

                  // Input sesuai filter
                  if (controller.selectedFilter.value == 'Kode Proyek') ...[
                    LzForm.select(
                      label: 'Kode Proyek',
                      hint: 'Pilih kode proyek',
                      model: forms.key('kode_proyek'),
                      style: OptionPickerStyle(withSearch: true),
                      onTap: () => controller.openPo(),
                    ),
                  ],

                  const SizedBox(height: 10),

                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: LzButton(
                            text: 'Tampilkan',
                            onTap: () async {
                              await controller.fetchDeliveries();
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: LzButton(
                            text: 'Cetak PDF',
                            color: Colors.green,
                            onTap: () async {
                              final kodeProyek =
                                  controller.forms.get('kode_proyek');
                              if (kodeProyek == null || kodeProyek.isEmpty) {
                                Toast.warning(
                                    'Silakan pilih kode proyek terlebih dahulu.');
                                return;
                              }

                              final query = {'kode_proyek': kodeProyek};

                              logg('[DEBUG] Mengirim query cetak PDF: $query');
                              final printController =
                                  Get.put(CetakPrintPoPpn());
                              await printController.cetakPrintPoPpn(query);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (controller.deliveryData.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    const SizedBox(height: 10),
                    ...controller.deliveryData.asMap().entries.map((entry) {
                      final index = entry.key + 1;
                      final item = entry.value;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: LzCard(
                          children: [
                            Text(
                              'No. $index',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const Divider(),
                            _buildBoldText('Tanggal Po', item['tgl_po']),
                            _buildBoldText('No. PO', item['no_po']),
                            _buildBoldText('Nama Barang', item['nama_barang']),
                            _buildBoldText('Qty', item['qty']),
                            _buildBoldText('Satuan', item['satuan_name']),
                            _buildBoldText('Unit Price', item['unit_price']),
                            _buildBoldText('Diskon', item['diskon']),
                            _buildBoldText('Amount', item['amount']),
                          ],
                        ),
                      );
                    }),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Helper untuk menampilkan teks dengan label tebal
Widget _buildBoldText(String label, dynamic value) {
  return RichText(
    text: TextSpan(
      style: const TextStyle(color: Colors.black, fontSize: 14),
      children: [
        TextSpan(
          text: '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: value?.toString() ?? '-'),
      ],
    ),
  );
}

/// 🔹 Fungsi helper status validasi
