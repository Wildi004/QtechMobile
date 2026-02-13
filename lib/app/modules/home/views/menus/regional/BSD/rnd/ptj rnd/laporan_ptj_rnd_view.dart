import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/RND/PTJ%20RND/laporan_ptj_rnd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/delivery%20po%20non%20ppn/cetak%20delivery/print_del_po_non.dart';

class LaporanPtjRndView extends GetView<LaporanPtjRndController> {
  const LaporanPtjRndView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LaporanPtjRndController());
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
                  ] else if (controller.selectedFilter.value == 'type') ...[
                    LzForm.select(
                      label: 'Pilih Type',
                      hint: 'Pilih Type',
                      model: forms.key('type'),
                      onTap: () async {
                        final data = controller.type;
                        forms.set('type').options(data.labelValue('name'));
                      },
                      onChange: (val) {
                        controller.deliveryData.clear();
                      },
                    ),
                  ],
                  if (controller.selectedFilter.value == 'tanggal-type') ...[
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
                    const SizedBox(height: 8),
                    LzForm.select(
                      label: 'Pilih Type',
                      hint: 'Pilih Type',
                      model: forms.key('type'),
                      onTap: () async {
                        final data = controller.type;
                        forms.set('type').options(data.labelValue('name'));
                      },
                    ),
                  ] else if (controller.selectedFilter.value ==
                      'bulan-tahun-type') ...[
                    LzForm.input(
                      label: 'Pilih Bulan',
                      hint: 'Pilih Bulan',
                      model: forms.key('bulan-tahun'),
                      onTap: () {
                        LzPicker.date(
                          context,
                          format: 'm/y',
                          minDate: DateTime(2018),
                          onSelect: (value) {
                            forms.set('bulan-tahun', value.format('yyyy-MM'));
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    LzForm.select(
                      label: 'Pilih Type',
                      hint: 'Pilih Type',
                      model: forms.key('type'),
                      onTap: () async {
                        final data = controller.type;
                        forms.set('type').options(data.labelValue('name'));
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
                              } else {
                                warning =
                                    'Silakan pilih jenis filter terlebih dahulu.';
                              }

                              if (warning != null) {
                                Toast.warning(warning);
                                return;
                              }

                              final printController = Get.put(PrintDelPoNon());
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

                      final int? status = item['status_dir_keuangan'];
                      final statusText = statusValidasiText(status);
                      final statusColor = statusValidasiColor(status);

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
                            _buildBoldText('Tanggal PTJ', item['tgl_ptj']),
                            _buildBoldText('No. PTJ', item['no_ptj']),
                            _buildBoldText('type', item['type']),
                            _buildBoldText(
                              'Nama Item',
                              (item['detail_ptj'] as List)
                                  .map((e) => e['nama_barang'])
                                  .join(', '),
                            ),
                            _buildBoldText(
                              'Qty',
                              (item['detail_ptj'] as List)
                                  .map((e) => e['qty'])
                                  .join(', '),
                            ),
                            _buildBoldText(
                              'Harga',
                              (item['detail_ptj'] as List)
                                  .map((e) => e['harga_satuan'])
                                  .join(', '),
                            ),
                            _buildBoldText(
                              'Total Harga',
                              (item['detail_ptj'] as List)
                                  .map((e) => e['total_harga'])
                                  .join(', '),
                            ),
                            _buildBoldText(
                              'Proyek',
                              (item['detail_ptj'] as List)
                                  .map((e) => e['kode_proyek'])
                                  .join(', '),
                            ),
                            _buildBoldText(
                              'Pekerjaan',
                              (item['detail_ptj'] as List)
                                  .map((e) => e['judul_kontrak'])
                                  .join(', '),
                            ),

                            // 🔹 Tambahkan status validasi dengan warna
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
