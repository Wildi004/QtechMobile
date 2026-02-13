import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/rab_it/rab_it.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/cetak%20rab%20hrd/cetak_rab_hrd.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Rab%20IT/rab_it_detail_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class RabItDetailView extends GetView<RabItDetailController> {
  final RabIt? data;

  const RabItDetailView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RabItDetailController()..data = data);
    final forms = controller.forms;
    String formatRupiah(num? value) {
      if (value == null) return '-';
      return NumberFormat.currency(
              locale: 'id', symbol: 'Rp ', decimalDigits: 0)
          .format(value);
    }

    final form = controller.forms;
    if (data != null) {
      form.fill(data!.toJson());
      controller.getDetails(data!);
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        appBar: CustomAppbar(
          title: 'Detail RAB',
          actions: [
            IconButton(
              onPressed: () {
                final cetakController = Get.put(CetakRabHrd());
                cetakController.getDataCetak(data!.id);
              },
              icon: Icon(Hi.printer),
            )
          ],
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
                  spacing: 10,
                  children: [
                    LzForm.input(
                      label: 'Kode RAB',
                      enabled: false,
                      model: forms.key('kode_rab'),
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Tanggal Pengajuan',
                          enabled: false,
                          model: forms.key('periode'),
                        ),
                        LzForm.input(
                          label: 'Departemen',
                          enabled: false,
                          model: forms.key('departemen_name'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  final groups = controller.weekGroups;

                  if (controller.isLoading.value) {
                    return const CustomLoading();
                  }

                  return LzListView(
                    gap: 12,
                    autoCache: true,
                    children: [
                      ...List.generate(groups.length, (gi) {
                        final g = groups[gi];
                        final isOpen =
                            controller.expandedWeeks[g.mingguKe] ?? false;

                        final subtotalText = NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(g.totalPerMinggu);

                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: InkTouch(
                                onTap: () => controller.toggleWeek(g.mingguKe),
                                padding: Ei.sym(v: 10, h: 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Minggu ke-${g.mingguKe}',
                                        style:
                                            Gfont.bold.copyWith(fontSize: 16),
                                      ),
                                    ),
                                    Text(subtotalText, style: Gfont.bold),
                                    8.width,
                                    Icon(isOpen
                                        ? Icons.expand_less
                                        : Icons.expand_more),
                                  ],
                                ),
                              ),
                            ),

                            // ISI — baru pakai LzCard, tapi tidak jadi tombol
                            if (isOpen)
                              ...List.generate(g.forms.length, (i) {
                                final form = g.forms[i];
                                return LzCard(
                                  color: Colors.white,
                                  gap: 10,
                                  children: [
                                    LzForm.input(
                                      label: 'Kategori RAB',
                                      enabled: false,
                                      model: form.key('kategori_rab_name'),
                                    ),
                                    LzForm.input(
                                      label: 'Nama Item',
                                      enabled: false,
                                      maxLines: 10,
                                      model: form.key('nama_item'),
                                    ),
                                    Intrinsic(
                                      gap: 10,
                                      children: [
                                        LzForm.input(
                                          label: 'Overheat',
                                          enabled: false,
                                          model: form.key('overheat'),
                                        ),
                                        LzForm.input(
                                          label: 'Minggu Ke',
                                          enabled: false,
                                          model: form.key('minggu_ke'),
                                        ),
                                      ],
                                    ),
                                    LzForm.input(
                                      label: 'Total Harga',
                                      enabled: false,
                                      model: form.key('total_harga'),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Catatan',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Html(
                                          data: form.get('catatan') ?? '-',
                                          style: {
                                            "body": Style(
                                              fontSize: FontSize(14),
                                              color: Colors.black87,
                                            ),
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }),
                          ],
                        );
                      }),

                      // Status Validasi (tetap)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          const Text(
                            'Status Validasi',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 12),
                          statusValidasiRow(
                              'Dir BSD', controller.data?.statusBsd),
                          const SizedBox(height: 6),
                        ],
                      ),
                    ],
                  );
                }),
              ),
              Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Pengajuan dana :',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(formatRupiah(_parseToNum(data!.grandtotal)))
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

num _parseToNum(dynamic value) {
  if (value == null) return 0;
  if (value is num) return value;
  if (value is String) {
    return num.tryParse(value.replaceAll(',', '').replaceAll(' ', '')) ?? 0;
  }
  return 0;
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:lazyui/lazyui.dart';
// import 'package:qrm_dev/app/data/models/models%20it/rab_it/rab_it.dart';
// import 'package:qrm_dev/app/modules/home/controllers/IT/Rab%20IT/rab_it_detail_controller.dart';
// import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/rab%20it/cetak%20it/cetak_rab_it.dart';
// import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
// import 'package:qrm_dev/app/widgets/custom_loading.dart';
// import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

// class RabItDetailView extends GetView<RabItDetailController> {
//   final RabIt? data;

//   const RabItDetailView({super.key, this.data});

//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut(() => RabItDetailController()..data = data);
//     final forms = controller.forms;
//     String formatRupiah(num? value) {
//       if (value == null) return '-';
//       return NumberFormat.currency(
//               locale: 'id', symbol: 'Rp ', decimalDigits: 0)
//           .format(value);
//     }

//     final form = controller.forms;
//     if (data != null) {
//       form.fill(data!.toJson());
//       controller.getDetails(data!);
//     }

//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         backgroundColor: const Color.fromARGB(255, 243, 243, 243),
//         appBar: CustomAppbar(
//           title: 'Detail RAB',
//           actions: [
//             IconButton(
//               onPressed: () {
//                 final cetakController = Get.put(CetakRabIt());
//                 cetakController.getDataCetak(data!.id);
//               },
//               icon: Icon(Hi.printer),
//             )
//           ],
//         ).appBar,
//         body: Obx(() {
//           bool loading = controller.isLoading.value;

//           if (loading) {
//             return CustomLoading();
//           }

//           return Column(
//             children: [
//               Container(
//                 padding: Ei.all(20),
//                 decoration: BoxDecoration(border: Br.only(['b'])),
//                 child: Column(
//                   spacing: 10,
//                   children: [
//                     LzForm.input(
//                       label: 'Kode RAB',
//                       enabled: false,
//                       model: forms.key('kode_rab'),
//                     ),
//                     Intrinsic(
//                       gap: 10,
//                       children: [
//                         LzForm.input(
//                           label: 'Tanggal Pengajuan',
//                           enabled: false,
//                           model: forms.key('periode'),
//                         ),
//                         LzForm.input(
//                           label: 'Departemen',
//                           enabled: false,
//                           model: forms.key('departemen_name'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: LzListView(
//                   gap: 10,
//                   children: [
//                     ...List.generate(controller.formDetails.length, (i) {
//                       final form = controller.formDetails[i];
//                       // final nomor = i + 1;

//                       return LzCard(
//                         gap: 10,
//                         children: [
//                           Text('Data ${controller.formDetails.length - i}',
//                               style: Gfont.bold.copyWith(fontSize: 16)),
//                           LzForm.input(
//                             label: 'Kategori RAB',
//                             enabled: false,
//                             model: form.key('kategori_rab_name'),
//                           ),
//                           LzForm.input(
//                             label: 'Nama Item',
//                             enabled: false,
//                             maxLines: 10,
//                             model: form.key('nama_item'),
//                           ),
//                           Intrinsic(
//                             gap: 10,
//                             children: [
//                               LzForm.input(
//                                 label: 'Overheat',
//                                 enabled: false,
//                                 model: form.key('overheat'),
//                               ),
//                               LzForm.input(
//                                 label: 'Minggu Ke',
//                                 enabled: false,
//                                 model: form.key('minggu_ke'),
//                               ),
//                             ],
//                           ),
//                           LzForm.input(
//                             label: 'Total Harga',
//                             enabled: false,
//                             model: form.key('total_harga'),
//                           ),
//                           LzForm.input(
//                             label: 'Catatan',
//                             enabled: false,
//                             maxLines: 10,
//                             model: form.key('catatan'),
//                           ),
//                         ],
//                       );
//                     }),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Status Validasi',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(height: 15),
//                         statusValidasiRow('Dir BSD', data?.statusBsd),
//                         SizedBox(height: 5),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 width: double.infinity,
//                 color: Colors.white,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Total Pengajuan dana :',
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                     Text(formatRupiah(_parseToNum(data!.grandtotal)))
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }
// }

// num _parseToNum(dynamic value) {
//   if (value == null) return 0;
//   if (value is num) return value;
//   if (value is String) {
//     return num.tryParse(value.replaceAll(',', '').replaceAll(' ', '')) ?? 0;
//   }
//   return 0;
// }
