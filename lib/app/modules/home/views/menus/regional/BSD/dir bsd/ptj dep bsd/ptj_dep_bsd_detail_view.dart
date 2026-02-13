import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/ptj_dep_bsd/ptj_dep_bsd.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Ptj%20Dev%20Bsd/ptj_dev_bsd_detail_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/ptj%20dep%20bsd/cetak/cetak_ptj_dep_bsd.dart';
import 'package:qrm_dev/app/modules/monitoring_proyek/views/setting_monitoring/Pekerjaan_monitoring_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class PtjDepBsdDetailView extends GetView<PtjDevBsdDetailController> {
  final PtjDepBsd? data;
  final bool showPrintButton;

  const PtjDepBsdDetailView({
    super.key,
    this.data,
    this.showPrintButton = false,
  });

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PtjDevBsdDetailController());

    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.getDetails(data!);
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Detail PTJ BSD',
          actions: [
            if (showPrintButton)
              IconButton(
                onPressed: () {
                  final cetakController = Get.put(CetakPtjDepBsd());
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
                      label: 'No. PTJ',
                      enabled: false,
                      model: forms.key('no_ptj_reg'),
                    ),
                    Intrinsic(
                      gap: 10,
                      children: [
                        LzForm.input(
                          label: 'Tanggal PTJ',
                          enabled: false,
                          model: forms.key('tgl_ptj'),
                        ),
                        LzForm.input(
                          label: 'Regional',
                          enabled: false,
                          model: forms.key('regional_name'),
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

                        return Column(
                          children: [
                            LzCard(
                              gap: 10,
                              children: [
                                Row(
                                  mainAxisAlignment: Maa.spaceBetween,
                                  children: [
                                    Text(
                                      'Data ${i + 1}',
                                      style: Gfont.bold.copyWith(fontSize: 16),
                                    ),
                                  ],
                                ),
                                LzForm.input(
                                  label: 'No. PTJ',
                                  enabled: false,
                                  model: form.key('no_ptj'),
                                ),
                                LzForm.input(
                                  label: 'Departemen',
                                  enabled: false,
                                  model: form.key('nama_pengajuan'),
                                ),
                                LzForm.input(
                                  label: 'Uraian',
                                  enabled: false,
                                  maxLines: 3,
                                  model: form.key('Uraian'),
                                ),
                                LzForm.input(
                                  label: 'Akun',
                                  enabled: false,
                                  maxLines: 3,
                                  model: form.key('akun_name'),
                                ),
                                Intrinsic(
                                  gap: 10,
                                  children: [
                                    LzForm.input(
                                      label: 'Akun',
                                      enabled: false,
                                      maxLines: 3,
                                      model: form.key('akun_lawan_name'),
                                    ),
                                    LzForm.input(
                                      label: 'Qty',
                                      enabled: false,
                                      model: form.key('qty'),
                                    ),
                                  ],
                                ),
                                Intrinsic(
                                  gap: 10,
                                  children: [
                                    LzForm.input(
                                      label: 'Harga',
                                      enabled: false,
                                      model: form.key('harga_satuan'),
                                    ),
                                  ],
                                ),
                                LzForm.input(
                                  label: 'Total',
                                  enabled: false,
                                  model: form.key('total_harga'),
                                ),
                                Intrinsic(
                                  children: [
                                    Text('Acc Dir. Keu'),
                                    statusValidasiRow(
                                      '',
                                      int.tryParse(controller.cards[i].statusAcc
                                              ?.toString() ??
                                          ''),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            // Divider sebagai garis bawah
                            Divider(
                              color: Colors.black26,
                              thickness: 2,
                              height: 20,
                            ),
                          ],
                        );
                      }),
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
                          formatRupiah(controller.details.total),
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
