import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Inv%20Del%20Po%20PPN%20Logiastik/cetak_inv_del_po_ppn_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/invoice%20delivery%20po%20logistik/invoice%20delivery%20material%20po%20ppn/cetak%20inv%20del%20po%20ppn/print_inv_del_po_ppn.dart';

class CetakInvDelPoPpnView extends GetView<CetakInvDelPoPpnController> {
  const CetakInvDelPoPpnView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CetakInvDelPoPpnController());
    final forms = controller.forms;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Obx(
        () => Column(
          children: [
            Expanded(
              child: LzListView(
                children: [
                  // Tambahkan di dalam LzListView -> children
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
                  ] else if (controller.selectedFilter.value ==
                      'bulan-tahun') ...[
                    LzForm.input(
                      label: 'Pilih Bulan',
                      hint: 'Pilih Bulan',
                      model: forms.key('bulan-tahun'),
                      onTap: () {
                        LzPicker.date(context,
                            format: 'm/y',
                            minDate: DateTime(2018), onSelect: (value) {
                          final formatted = value.format('yyyy-MM');
                          forms.set('bulan-tahun', formatted);
                          controller.deliveryData.clear();
                        });
                      },
                    ),
                  ] else if (controller.selectedFilter.value ==
                      'Kode Proyek') ...[
                    LzForm.select(
                      label: 'Kode Proyek',
                      hint: 'Masukkan kode proyek',
                      model: forms.key('kode_proyek'),
                      style: OptionPickerStyle(withSearch: true),
                      onTap: () => controller.openPo(),
                    ),
                  ] else if (controller.selectedFilter.value == 'Status') ...[
                    LzForm.select(
                      label: 'Status',
                      hint: 'Pilih Status',
                      model: forms.key('status'),
                      onTap: () async {
                        final data = await controller.getStatus().overlay();
                        forms.set('status').options(data.labelValue('name'));
                      },
                    ),
                  ] else if (controller.selectedFilter.value ==
                      'Tanggal dan Status') ...[
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
                    LzForm.select(
                      label: 'Status',
                      hint: 'Pilih Status',
                      model: forms.key('status'),
                      onTap: () async {
                        final data = await controller.getStatus().overlay();
                        forms.set('status').options(data.labelValue('name'));
                      },
                    ),
                  ] else if (controller.selectedFilter.value ==
                      'Bulan dan Status') ...[
                    LzForm.input(
                      label: 'Pilih Bulan',
                      hint: 'Pilih Bulan',
                      model: forms.key('bulan-tahun'),
                      onTap: () {
                        LzPicker.date(context,
                            format: 'm/y',
                            minDate: DateTime(2018), onSelect: (value) {
                          final formatted = value.format('yyyy-MM');
                          forms.set('bulan-tahun', formatted);
                        });
                      },
                    ),
                    LzForm.select(
                      label: 'Status',
                      hint: 'Pilih Status',
                      model: forms.key('status'),
                      onTap: () async {
                        final data = await controller.getStatus().overlay();
                        forms.set('status').options(data.labelValue('name'));
                      },
                    ),
                  ],

                  const SizedBox(height: 10),

                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Tombol Tampilkan
                        Expanded(
                          child: LzButton(
                            text: 'Tampilkan',
                            onTap: () async {
                              await controller.fetchDeliveries();
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Tombol Cetak PDF
                        Expanded(
                          child: LzButton(
                            text: 'Cetak PDF',
                            color: Colors.green,
                            onTap: () async {
                              final key = controller.selectedFilter.value;
                              final forms = controller.forms;
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
                              } else if (key == 'bulan-tahun') {
                                final bulanTahun = forms.get('bulan-tahun');
                                if (bulanTahun == null || bulanTahun.isEmpty) {
                                  warning =
                                      'Silakan pilih bulan dan tahun terlebih dahulu.';
                                } else {
                                  query['bulan-tahun'] = bulanTahun;
                                }
                              } else if (key == 'Kode Proyek') {
                                final kodeProyek = forms.get('kode_proyek');
                                if (kodeProyek == null || kodeProyek.isEmpty) {
                                  warning =
                                      'Silakan isi kode proyek terlebih dahulu.';
                                } else {
                                  query['kode_proyek'] = kodeProyek;
                                }
                              } else {
                                warning =
                                    'Silakan pilih jenis filter terlebih dahulu.';
                              }

                              if (warning != null) {
                                Toast.warning(warning);
                                return;
                              }

                              final printController =
                                  Get.put(PrintInvDelPoPpn());
                              await printController.cetakDelPoPpn(query);
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
                            _buildBoldText('No. Invoice', item['no_invoice']),
                            _buildBoldText('Tgl. Invoice', item['tgl_inv']),
                            _buildBoldText('No. Delivery', item['no_delivery']),
                            _buildBoldText('No. Po', item['no_po']),
                            _buildBoldText('Termin', item['lama_hari']),

                            // 🔹 Tambahkan status pembayaran di sini
                            Builder(builder: (_) {
                              final statusText =
                                  statusPembayaranText(item['no_hide_ptj']);
                              final color =
                                  statusPembayaranColor(item['no_hide_ptj']);

                              return RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  children: [
                                    const TextSpan(
                                      text: 'Status Pembayaran: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: statusText,
                                      style: TextStyle(color: color),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            _buildBoldText('Jatuh Tempo', item['term_to']),
                            _buildBoldText('Sub Total', item['sub_total']),

                            _buildBoldText(
                                'Cara Pembayaran', item['cara_pembayaran']),
                            _buildBoldText('Catatan', item['catatan']),

                            // 🔹 Tetap tampilkan status direktur keuangan
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
                                    text: statusValidasiText(
                                        item['status_dir_keuangan']),
                                    style: TextStyle(
                                      color: statusValidasiColor(
                                          item['status_dir_keuangan']),
                                    ),
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

/// 🔹 Helper untuk menentukan teks status pembayaran
/// 🔹 Helper untuk menentukan teks status pembayaran
String statusPembayaranText(dynamic noHidePtj) {
  if (noHidePtj == null ||
      noHidePtj.toString().trim().isEmpty ||
      noHidePtj.toString().toLowerCase() == 'null') {
    return 'Belum Dibayar';
  } else {
    return 'Sudah Dibayar';
  }
}

/// 🔹 Helper untuk menentukan warna status pembayaran
Color statusPembayaranColor(dynamic noHidePtj) {
  if (noHidePtj == null ||
      noHidePtj.toString().trim().isEmpty ||
      noHidePtj.toString().toLowerCase() == 'null') {
    return Colors.red; // merah = belum dibayar
  } else {
    return Colors.green; // hijau = sudah dibayar
  }
}
