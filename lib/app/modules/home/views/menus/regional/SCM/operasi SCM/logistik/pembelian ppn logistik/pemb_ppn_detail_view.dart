import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pembelian_ppn/pembelian_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Pembelian%20PPN/pemb_ppn_detail_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/po%20ppn/cetak%20po%20ppn/cetak_po_ppn.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class PembPpnDetailView extends GetView<PembPpnDetailController> {
  final PembelianPpn? data;
  final bool showPrintButton;

  const PembPpnDetailView({
    super.key,
    this.data,
    this.showPrintButton = false,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(PembPpnDetailController());

    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.data = data;
      final datas = data!.toJson();
      datas['sub_total'] = toRupiah(data!.subTotal ?? 0);

      forms.fill(datas);

      if (controller.formDetails.isEmpty) {
        controller.getDetails(data!);
      }
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Detail Pembelian PPN',
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
                      label: 'No. Pembelian',
                      enabled: false,
                      model: forms.key('no_pembelian'),
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Tanggal Pembelian',
                          enabled: false,
                          model: forms.key('tgl_beli'),
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
                    ...List.generate(controller.formDetails.length, (i) {
                      final form = controller.formDetails[i];

                      return LzCard(
                        children: [
                          LzForm.input(
                            enabled: false,
                            label: 'Deskripsi',
                            maxLines: 4,
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
                            model: form.key('harga_satuan'),
                          ),
                          LzForm.input(
                            enabled: false,
                            label: 'Total',
                            model: form.key('total_harga'),
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
                        statusValidasiRow('Gm', data?.statusGmRegional),
                        SizedBox(height: 15),
                        statusValidasiRow(
                            'Dir Keuangan', data?.statusDirKeuangan),
                      ],
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

Widget buildTextField(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(value),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget buildBuktiNotaField(String label, String? fileName, controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                fileName ?? '-',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (fileName != null)
              IconButton(
                icon: const Icon(Icons.remove_red_eye),
                onPressed: () {
                  controller.openFileWithToken(fileName);
                },
              ),
          ],
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}
