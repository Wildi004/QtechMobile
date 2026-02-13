import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_po_non_ppn/del_po_non_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Del%20PO%20Non%20PPN/del_po_non_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class DelPoNonDetailView extends GetView<DelPoNonController> {
  final DelPoNonPpn? data;
  final String? noDelpoNon;

  const DelPoNonDetailView({super.key, this.data, this.noDelpoNon});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    if (data != null) {
      final datas = data!.toJson();
      controller.fillFormDetails(data!.detail);

      forms.fill(datas);
    }
    if (noDelpoNon != null) {
      controller.fillFormDetails(data!.detail);
    }
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Detail Delivery',
      ).appBar,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
                child: LzListView(
              gap: 10,
              children: [
                LzForm.input(
                  enabled: false,
                  label: 'No. Delivery',
                  model: forms.key('no_delivery'),
                ),
                LzForm.input(
                  enabled: false,
                  label: 'No. PO',
                  model: forms.key('no_po'),
                ),
                Intrinsic(gap: 10, children: [
                  LzForm.input(
                    enabled: false,
                    label: 'Tgl Pengiriman',
                    model: forms.key('shipment_date'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Tgl Diterima',
                    model: forms.key('received_date'),
                  ),
                ]),
                LzForm.input(
                  enabled: false,
                  label: 'Lokasi Kirim',
                  model: forms.key('lokasi_kirim'),
                ),
                LzForm.input(
                  enabled: false,
                  label: 'Ekspedisi',
                  model: forms.key('ekspedisi'),
                ),
                LzForm.input(
                  enabled: false,
                  label: 'Penerima',
                  model: forms.key('penerima'),
                ),
                if (controller.formDetails.isNotEmpty)
                  Obx(() => Column(
                        children:
                            List.generate(controller.formDetails.length, (i) {
                          final form = controller.formDetails[i];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: LzCard(
                              gap: 10,
                              children: [
                                Text(
                                  'Barang ${i + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Kode Material',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    LzForm.input(
                                      enabled: false,
                                      maxLines: 99,
                                      model: form.key('kode'),
                                    ),
                                  ],
                                ),
                                LzForm.input(
                                  label: 'Qty',
                                  enabled: false,
                                  model: form.key('qty'),
                                ),
                                LzForm.input(
                                  label: 'Nama Barang',
                                  maxLines: 99,
                                  enabled: false,
                                  model: form.key('namabarang'),
                                ),
                                LzForm.input(
                                  label: 'jumlah Keluar',
                                  maxLines: 99,
                                  enabled: false,
                                  model: form.key('jumlahKeluar'),
                                ),
                                LzForm.input(
                                  label: 'Berat Satuan',
                                  maxLines: 99,
                                  enabled: false,
                                  model: form.key('beratSatuan'),
                                ),
                                LzForm.input(
                                  label: 'total',
                                  maxLines: 99,
                                  enabled: false,
                                  model: form.key('total'),
                                ),
                              ],
                            ),
                          );
                        }),
                      )),
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
                    statusValidasiRow('GM : ', data?.statusGmRegional),
                    SizedBox(height: 15),
                    statusValidasiRow(
                        'Dir Keuangan : ', data?.statusDirKeuangan),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
