import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/pengajuan%20global/pengajuan%20sudah%20validasi/pengajuan_sudah_validasi/pengajuan_sudah_validasi.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_pengajuan_controller/detail_pengajuan_hrd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/pengajuan_hrd/cetak%20pengajuan%20hrd/cetak_pengajuan_hrd.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class DetailPengajuanHrdView extends GetView<DetailPengajuanHrdController> {
  final PengajuanSudahValidasi? data;
  final bool showPrintButton;

  const DetailPengajuanHrdView({
    super.key,
    this.data,
    this.showPrintButton = false,
  });

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DetailPengajuanHrdController()..data = data);
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
            if (showPrintButton) // <- Tampilkan hanya kalau true
              IconButton(
                onPressed: () {
                  final cetakController = Get.put(CetakPengajuanHrd());
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
