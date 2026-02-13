import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_pemb_non_ppn/del_pemb_non_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/Logistik%20Jakarta/Delivery%20Pembelian%20Non%20PPN%20Jkt/del_pemb_jkt_non_ppn_detail_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/po%20ppn/cetak%20po%20ppn/cetak_po_ppn.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class DelPembJktNonPpnDetailView
    extends GetView<DelPembJktNonPpnDetailController> {
  final DelPembNonPpn? data;
  final bool showPrintButton;

  const DelPembJktNonPpnDetailView({
    super.key,
    this.data,
    this.showPrintButton = false,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(DelPembJktNonPpnDetailController());

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
          title: 'Detail Delivery Pembelian Non PPN',
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
                      label: 'No. Delivery',
                      enabled: false,
                      model: forms.key('no_delivery'),
                    ),
                    LzForm.input(
                      label: 'No. Pembelian',
                      enabled: false,
                      model: forms.key('no_pembelian'),
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Shipment Date',
                          enabled: false,
                          model: forms.key('shipment_date'),
                        ),
                        LzForm.input(
                          label: 'Received Date',
                          enabled: false,
                          model: forms.key('received_date'),
                        ),
                      ],
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Lokasi Kirim',
                          enabled: false,
                          model: forms.key('lokasi_pengiriman'),
                        ),
                        LzForm.input(
                          label: 'Penerima',
                          enabled: false,
                          model: forms.key('penerima'),
                        ),
                      ],
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Ekspedisi',
                          enabled: false,
                          model: forms.key('ekspedisi'),
                        ),
                      ],
                    ),
                    ...List.generate(controller.formDetails.length, (i) {
                      final form = controller.formDetails[i];

                      return LzCard(
                        gap: 10,
                        padding: Ei.all(10),
                        children: [
                          Text(
                            'Barang ${i + 1}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          // 🔹 Field-field form detail

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
                                label: 'Berat Satuan',
                                model: form.key('berat_satuan'),
                              ),
                            ],
                          ),
                          LzForm.input(
                            enabled: false,
                            label: 'Jumlah Keluar',
                            model: form.key('jumlah_keluar'),
                          ),

                          LzForm.input(
                            enabled: false,
                            label: 'Total',
                            model: form.key('total'),
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
                        statusValidasiRow('GM : ', data?.statusGmRegional),
                        SizedBox(height: 15),
                        statusValidasiRow(
                            'Dir Keuangan : ', data?.statusDirKeuangan),
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
