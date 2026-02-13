import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Po%20Non%20Ppn/lapopran_po_non_ppn_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/po%20non/laporan%20dan%20cetak/cetak_po_non_ppn_view.dart';

class LaporanPoNonPpnView extends GetView<LapopranPoNonPpnController> {
  const LaporanPoNonPpnView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LapopranPoNonPpnController());
    final forms = controller.forms;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Obx(
        () => Column(
          children: [
            Expanded(
              child: LzListView(
                children: [
                  // 🔹 Filter berdasarkan
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

                  // 🔹 Input untuk tanggal
                  if (controller.selectedFilter.value == 'tanggal') ...[
                    LzForm.input(
                      label: 'Pilih Tanggal',
                      hint: 'Pilih',
                      model: forms.key('tanggal'),
                      onTap: () {
                        LzPicker.date(context, minDate: DateTime(1900),
                            onSelect: (date) {
                          forms.set('tanggal', date.format('yyyy-MM-dd'));
                        });
                      },
                    ),
                  ]

                  // 🔹 Input untuk bulan & tahun
                  else if (controller.selectedFilter.value ==
                      'bulan tahun') ...[
                    LzForm.input(
                      label: 'Pilih Bulan',
                      hint: 'Pilih Bulan',
                      model: forms.key('bulan_tahun'),
                      onTap: () {
                        LzPicker.date(context,
                            format: 'm/y',
                            minDate: DateTime(2018), onSelect: (value) {
                          final formatted = value.format('yyyy-MM');
                          forms.set('bulan_tahun', formatted);
                          controller.deliveryData.clear();
                        });
                      },
                    ),
                  ],

                  const SizedBox(height: 10),

                  // 🔹 Tombol tampilkan dan cetak
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
                              final key = controller.selectedFilter.value;
                              final query = <String, dynamic>{};
                              String? warning;

                              if (key == 'tanggal') {
                                final tanggal = forms.get('tanggal');
                                if (tanggal == null || tanggal.isEmpty) {
                                  warning =
                                      'Silakan pilih tanggal terlebih dahulu.';
                                } else {
                                  query['tanggal'] = tanggal;
                                }
                              } else if (key == 'bulan tahun') {
                                final bulanTahun = forms.get('bulan_tahun');
                                if (bulanTahun == null || bulanTahun.isEmpty) {
                                  warning =
                                      'Silakan pilih bulan dan tahun terlebih dahulu.';
                                } else {
                                  query['bulan_tahun'] = bulanTahun;
                                }
                              } else {
                                warning =
                                    'Silakan pilih jenis filter terlebih dahulu.';
                              }

                              if (warning != null) {
                                Toast.warning(warning);
                                return;
                              }

                              logg('[DEBUG] Mengirim query cetak PDF: $query');
                              final printController =
                                  Get.put(CetakPoNonPpnView());
                              await printController.cetakPrintPoNonPpn(query);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 🔹 Tampilkan data
                  if (controller.deliveryData.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    const SizedBox(height: 10),
                    ...controller.deliveryData.asMap().entries.map((entry) {
                      final index = entry.key + 1;
                      final item = entry.value;

                      final int? status = item['status_dir_keuangan'];
                      final statusText = statusValidasiText(status);
                      final statusColor = statusValidasiColor(status);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: LzCard(
                          children: [
                            Text('No. $index',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            const Divider(),
                            _buildBoldText('Tanggal Po', item['tgl_po']),
                            _buildBoldText('No. PO', item['no_po']),
                            _buildBoldText(
                                'Nama Supplier', item['suplier_name']),
                            _buildBoldText('Tgl. Kirim', item['term_from']),
                            _buildBoldText('Termin', item['lama_hari']),
                            _buildBoldText('Jatuh Tempo', item['term_to']),
                            _buildBoldText('Total PO (Rp.)', item['total']),
                            _buildBoldText(
                                'Jenis Pembayaran', item['jenis_pembayaran']),
                            _buildBoldText(
                                'Cara Pembayaran', item['cara_pembayaran']),
                            _buildBoldText('Catatan', item['catatan']),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                children: [
                                  const TextSpan(
                                    text: 'Status Dir. Keu: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: statusText,
                                    style: TextStyle(color: statusColor),
                                  ),
                                ],
                              ),
                            ),
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
String statusValidasiText(int? status) {
  switch (status) {
    case 0:
      return 'Belum Diterima';
    case 1:
      return 'Diterima';
    case 2:
      return 'Tolak';
    case 3:
      return '-';
    case 4:
      return 'Cancel';
    default:
      return 'Not Check';
  }
}

Color statusValidasiColor(int? status) {
  switch (status) {
    case 0:
      return Colors.orange;
    case 1:
      return Colors.green;
    case 2:
      return Colors.red;
    case 3:
      return Colors.grey;
    default:
      return Colors.black45;
  }
}
