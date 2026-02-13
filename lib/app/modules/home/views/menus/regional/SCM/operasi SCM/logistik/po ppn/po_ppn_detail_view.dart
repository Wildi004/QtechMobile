import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/po_ppn/po_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Po%20Ppn/po_ppn_detail_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/po%20ppn/cetak%20po%20ppn/cetak_po_ppn.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class PoPpnDetailView extends GetView<PoPpnDetailController> {
  final PoPpn? data;
  final bool showPrintButton;

  const PoPpnDetailView({
    super.key,
    this.data,
    this.showPrintButton = false,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(PoPpnDetailController());

    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.data = data;
      final datas = data!.toJson();
      datas['sub_total'] = toRupiah(data!.subTotal ?? 0);
      datas['tax'] = toRupiah(data!.tax ?? 0);
      datas['freight_cost'] = toRupiah(data!.freightCost ?? 0);
      datas['dp'] = toRupiah(data!.dp ?? 0);
      datas['jmlDp'] = toRupiah(data!.jmlDp ?? 0);

      forms.fill(datas);

      if (controller.formDetails.isEmpty) {
        controller.getDetails(data!);
      }
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Detail PO PPN',
          actions: [
            IconButton(
              onPressed: () {
                final cetakController = Get.put(CetakPoPpn());
                cetakController.getDataCetak(data!.noHide);
              },
              icon: Icon(Hi.printer),
            )
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
                      label: 'No. PO',
                      enabled: false,
                      model: forms.key('no_po'),
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Tanggal PO',
                          enabled: false,
                          model: forms.key('tgl_po'),
                        ),
                        LzForm.input(
                          label: 'Delivery Date',
                          enabled: false,
                          model: forms.key('delivery_date'),
                        ),
                      ],
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Shipment',
                          enabled: false,
                          model: forms.key('shipment'),
                        ),
                        LzForm.input(
                          label: 'Cara Pembayaran',
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
                          label: 'Lama Hari',
                          enabled: false,
                          model: forms.key('lama_hari'),
                        ),
                      ],
                    ),
                    LzForm.input(
                      label: 'Suplier',
                      enabled: false,
                      model: forms.key('suplier_name'),
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Term From',
                          enabled: false,
                          model: forms.key('term_from'),
                        ),
                        LzForm.input(
                          label: 'Term To',
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
                      label: 'Prepared By',
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
                    Padding(
                      padding: const EdgeInsets.only(right: 250),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize
                                            .min, // biar ngikutin isi
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
                                            model: controller.forms
                                                .key('sub_total'),
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
                                            model:
                                                controller.forms.key('jmlDp'),
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
