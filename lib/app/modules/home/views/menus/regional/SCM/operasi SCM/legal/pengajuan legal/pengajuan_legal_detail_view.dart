import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20legal/pengajuan_legal/pengajuan_legal.dart';
import 'package:qrm_dev/app/modules/home/controllers/LEGAL/Pengajuan%20Legal/pengajuan_legal_detail_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/pengajuan%20legal/cetak%20legal/cetak_pengajuan_legal.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class PengajuanLegalDetailView extends GetView<PengajuanLegalDetailController> {
  final PengajuanLegal? data;
  final bool showPrintButton;

  const PengajuanLegalDetailView({
    super.key,
    this.data,
    this.showPrintButton = false,
  });

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PengajuanLegalDetailController()..data = data);
    String formatRupiah(num? value) {
      if (value == null) return '-';
      return NumberFormat.currency(
              locale: 'id', symbol: 'Rp ', decimalDigits: 0)
          .format(value);
    }

    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.getDetails(data!);
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Detail Pengajuan',
          actions: [
            if (showPrintButton)
              IconButton(
                onPressed: () {
                  final cetakController = Get.put(CetakPengajuanLegal());
                  cetakController.getDataCetak(data!.noHide);
                },
                icon: Icon(Hi.printer),
              ),
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
                      label: 'No. Pengajuan',
                      enabled: false,
                      model: forms.key('no_pengajuan'),
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Tanggal Pengajuan',
                          enabled: false,
                          model: forms.key('tgl_pengajuan'),
                        ),
                        LzForm.input(
                          label: 'Departemen',
                          enabled: false,
                          model: forms.key('dep_name'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () => LzListView(
                    gap: 10,
                    children: [
                      ...List.generate(controller.formDetails.length, (i) {
                        final form = controller.formDetails[i];

                        return LzCard(
                          color: statusValidasiCardColor(
                            int.tryParse(
                                controller.cards[i].statusAcc?.toString() ??
                                    ''),
                          ),
                          gap: 10,
                          children: [
                            Row(
                              mainAxisAlignment: Maa.spaceBetween,
                              children: [
                                Text(
                                    'Data ${controller.formDetails.length - i}',
                                    style: Gfont.bold.copyWith(fontSize: 16)),
                                statusValidasiRow(
                                  '',
                                  int.tryParse(controller.cards[i].statusAcc
                                          ?.toString() ??
                                      ''),
                                ),
                              ],
                            ),
                            LzForm.input(
                              label: 'Jenis RAB',
                              enabled: false,
                              model: form.key('jenis_rab'),
                            ),
                            Intrinsic(
                              gap: 10,
                              children: [
                                LzForm.input(
                                  label: 'Nama Barang',
                                  maxLines: 99,
                                  enabled: false,
                                  model: form.key('nama_barang'),
                                ),
                              ],
                            ),
                            Intrinsic(
                              gap: 10,
                              children: [
                                LzForm.input(
                                  label: 'Qty',
                                  enabled: false,
                                  model: form.key('qty'),
                                ),
                                LzForm.input(
                                  label: 'Harga Satuan',
                                  enabled: false,
                                  model: form.key('harga'),
                                ),
                              ],
                            ),
                            LzForm.input(
                              label: 'Total',
                              enabled: false,
                              model: form.key('total_harga'),
                            ),
                          ],
                        );
                      }),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 15),
                          Text(
                            (controller.details.statusGmBsd == 1)
                                ? 'Pengajuan telah divalidasi oleh Dir. BSD'
                                : 'Belum divalidasi',
                            style: GoogleFonts.poppins().copyWith(
                                color: Colors.black,
                                fontWeight: Fw.bold,
                                fontSize: 10),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LzCard(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Pengajuan :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.045)),
                        Text(
                          formatRupiah(controller.details.subTotal),
                          softWrap: false,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
