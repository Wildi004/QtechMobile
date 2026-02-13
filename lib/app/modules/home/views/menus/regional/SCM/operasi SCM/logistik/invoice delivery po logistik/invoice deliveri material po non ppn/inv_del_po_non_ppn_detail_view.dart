import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/inv_del_po_non_ppn/inv_del_po_non_ppn.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Inv%20Del%20Po%20Non%20PPN%20Logistik/inv_del_po_non_ppn_detail_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/file%20download/download_file.dart';
import 'package:qrm_dev/app/widgets/file%20download/file_viewer.dart';

class InvDelPoNonPpnDetailView extends GetView<InvDelPoNonPpnDetailController> {
  final InvDelPoNonPpn? data;
  final bool showPrintButton;

  const InvDelPoNonPpnDetailView({
    super.key,
    this.data,
    this.showPrintButton = false,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(InvDelPoNonPpnDetailController());

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
          title: 'Detail Inv Delivery PO Non PPN',
          actions: [
            IconButton(
              onPressed: () {
                if (data?.image != null && data!.image!.isNotEmpty) {
                  FileHelper.openFileWithTokenAndShowViewer(
                    fileUrl: data!.image!,
                    getToken: () async => storage.read('token'),
                    viewerPage: (bytes, fileType) =>
                        DownloadFile(fileBytes: bytes, fileType: fileType),
                  );
                } else {
                  Toast.show('File tidak tersedia');
                }
              },
              icon: const Icon(Hi.pdf01),
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
                      enabled: false,
                      label: 'sub Total',
                      model: forms.key('sub_total'),
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
