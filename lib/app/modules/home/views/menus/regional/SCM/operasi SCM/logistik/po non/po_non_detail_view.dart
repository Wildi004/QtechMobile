import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/po_non/po_non.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Po%20Non%20Ppn/po_non_detail_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/pengajuan%20logistik/cetak%20pengajuan%20logistik/cetak_pengajuan_logistik.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class PoNonDetailView extends GetView<PoNonDetailController> {
  final PoNon? data;
  final bool showPrintButton;

  const PoNonDetailView({
    super.key,
    this.data,
    this.showPrintButton = false,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(PoNonDetailController());

    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.data = data;

      // 🚀 panggil sekali biar formDetails terisi
      if (controller.formDetails.isEmpty) {
        controller.getDetails(data!);
      }
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Detail PO (Non PPN)',
          actions: [
            if (showPrintButton)
              IconButton(
                onPressed: () {
                  final cetakController = Get.put(CetakPengajuanLogistik());
                  cetakController.getDataCetak(data!.noHide);
                },
                icon: Icon(Hi.printer),
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
                      label: 'No. PO', //
                      enabled: false,
                      model: forms.key('no_po_nonppn'),
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Tanggal PO', //
                          enabled: false,
                          model: forms.key('tgl_po'),
                        ),
                        LzForm.input(
                          label: 'Delivery Date', //
                          enabled: false,
                          model: forms.key('tgl_dikirim'),
                        ),
                      ],
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Cara Pembayaran', //
                          enabled: false,
                          model: forms.key('cara_pembayaran'),
                        ),
                      ],
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Jenis Pembayaran',
                          enabled: false,
                          model: forms.key('jenis_pembayaran'),
                        ),
                        LzForm.input(
                          label: 'Lama Hari', //
                          enabled: false,
                          model: forms.key('lama_hari'),
                        ),
                      ],
                    ),
                    LzForm.input(
                      label: 'Suplier', //
                      enabled: false,
                      model: forms.key('suplier_name'),
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Term From', //
                          enabled: false,
                          model: forms.key('term_from'),
                        ),
                        LzForm.input(
                          label: 'Term To', //
                          enabled: false,
                          model: forms.key('term_to'),
                        ),
                      ],
                    ),
                    LzForm.input(
                      label: 'Lokasi Pengiriman',
                      enabled: false,
                      model: forms.key('lokasi_pengiriman'),
                    ),
                    LzForm.input(
                      label: 'Dibuat Oleh', //
                      enabled: false,
                      model: forms.key('prepared_by_name'),
                    ),
                    ...List.generate(controller.formDetails.length, (i) {
                      final form = controller.formDetails[i];

                      return LzCard(
                        children: [
                          LzForm.input(
                            enabled: false,
                            label: 'Nama Barang',
                            model: form.key('nama_barang'),
                          ),
                          Intrinsic(
                            gap: 10,
                            children: [
                              LzForm.input(
                                enabled: false,
                                label: 'Qty',
                                model: form.key('qty'),
                              ),
                              LzForm.input(
                                enabled: false,
                                label: 'Satuan',
                                model: form.key('satuan_name'),
                              ),
                            ],
                          ),
                          LzForm.input(
                            enabled: false,
                            label: 'Diskon',
                            model: form.key('diskon'),
                          ),
                          LzForm.input(
                            enabled: false,
                            label: 'Harga Satuan',
                            model: form.key('unit_price'),
                          ),
                          LzForm.input(
                            enabled: false,
                            label: 'Total',
                            model: form.key('amount'),
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
                        statusValidasiRow('GM : ', data?.statusBsd),
                        SizedBox(height: 15),
                        statusValidasiRow(
                            'Dir Keuangan : ', data?.statusDirKeuangan),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 250),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: 16,
                                    right: 16,
                                    top: 16,
                                    bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom +
                                        16,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Detail Perhitungan",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        LzForm.input(
                                          label: 'Sub Total',
                                          enabled: false,
                                          model:
                                              controller.forms.key('sub_total'),
                                        ),
                                        LzForm.input(
                                          label: 'Tax',
                                          enabled: false,
                                          model: controller.forms.key('tax'),
                                        ),
                                        LzForm.input(
                                          label: 'Freight Cost',
                                          enabled: false,
                                          model: controller.forms
                                              .key('freight_cost'),
                                        ),
                                        LzForm.input(
                                          label: 'Dp',
                                          enabled: false,
                                          model: controller.forms.key('dp'),
                                        ),
                                        LzForm.input(
                                          label: 'Jumlah Dp',
                                          enabled: false,
                                          model: controller.forms.key('jmlDp'),
                                        ),
                                        const SizedBox(height: 16),
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Tutup"),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Hi.eye,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
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

String toRupiah(dynamic value) {
  final rupiah =
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
  return rupiah.format(int.tryParse(value.toString()) ?? 0);
}
