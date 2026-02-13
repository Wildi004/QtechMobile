import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/inv_del_pemb_ppn/inv_del_pemb_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Invoice%20Delivery%20Pembelian%20PPN/inv_del_pemb_ppn_detail_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/po%20ppn/cetak%20po%20ppn/cetak_po_ppn.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class InvDelPembPpnDetailView extends GetView<InvDelPembPpnDetailController> {
  final InvDelPembPpn? data;
  final bool showPrintButton;

  const InvDelPembPpnDetailView({
    super.key,
    this.data,
    this.showPrintButton = false,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(InvDelPembPpnDetailController());

    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.data = data;
      final datas = data!.toJson();
      forms.fill(datas);
      if (controller.formDetails.isEmpty) {
        controller.getDetails(data!);
      }
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Detail Invoice Delivery Pembelian PPN',
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
                      label: 'No. Invoice',
                      enabled: false,
                      model: forms.key('no_invoice'),
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Tanggal Invoice',
                          enabled: false,
                          model: forms.key('tgl_inv'),
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
                          label: 'Nama Suplier',
                          enabled: false,
                          model: forms.key('suplier_name'),
                        ),
                        LzForm.input(
                          label: 'Lama Hari',
                          enabled: false,
                          model: forms.key('lama_hari'),
                        ),
                      ],
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
                    ...List.generate(controller.formDetails.length, (i) {
                      final form = controller.formDetails[i];

                      return LzCard(
                        children: [
                          LzForm.input(
                            enabled: false,
                            label: 'Kode Material',
                            model: form.key('kode_material'),
                          ),
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
                                label: 'Harga Satuan',
                                model: form.key('harga_satuan'),
                              ),
                            ],
                          ),
                          LzForm.input(
                            enabled: false,
                            label: 'Total',
                            model: form.key('total_harga'),
                          ),
                        ],
                      );
                    }),
                    LzForm.input(
                      label: 'Sub Total',
                      enabled: false,
                      model: forms.key('sub_total'),
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'PPN',
                          enabled: false,
                          model: forms.key('ppn'),
                        ),
                        LzForm.input(
                          label: 'Jumlah PPN',
                          enabled: false,
                          model: forms.key('jml_ppn'),
                        ),
                      ],
                    ),
                    LzForm.input(
                      label: 'Grand Total',
                      enabled: false,
                      model: forms.key('grandtotal'),
                    ),
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
