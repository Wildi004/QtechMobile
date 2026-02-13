import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/pengajuan_dep_bsd/pengajuan_dep_bsd.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Pengajuan%20Dev%20Bsd/pengajuan_dev_bsd_detail_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/pengajuan%20dep%20bsd/cetak/cetak_pengajuan_dep_bsd.dart';
import 'package:qrm_dev/app/modules/monitoring_proyek/views/setting_monitoring/Pekerjaan_monitoring_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class PengajuanDepBsdDetailView
    extends GetView<PengajuanDevBsdDetailController> {
  final PengajuanDepBsd? data;
  final bool showPrintButton;

  const PengajuanDepBsdDetailView({
    super.key,
    this.data,
    this.showPrintButton = false,
  });

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PengajuanDevBsdDetailController());

    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.getDetails(data!);
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Detail Pengajuan BSD',
          actions: [
            if (showPrintButton)
              IconButton(
                onPressed: () {
                  final cetakController = Get.put(CetakPengajuanDepBsd());
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
                      model: forms.key('no_pengajuan_reg'),
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
                                IconButton(
                                  onPressed: () {
                                    controller.openDetail(controller.cards[i]);
                                  },
                                  icon: Icon(Hi.eye),
                                )
                              ],
                            ),
                            LzForm.input(
                              label: 'Departemen',
                              enabled: false,
                              model: form.key('nama_pengajuan'),
                            ),
                            LzForm.input(
                              label: 'No Pengajuan Departemen',
                              enabled: false,
                              model: form.key('no_pengajuan_dep'),
                            ),
                            LzForm.input(
                              label: 'Nilai Pengajuan',
                              enabled: false,
                              model: form.key('total_harga'),
                            ),
                            Intrinsic(
                              children: [
                                Text('Acc Dir. Keu'),
                                statusValidasiRow(
                                  '',
                                  int.tryParse(controller
                                          .details.statusDirKeuangan
                                          ?.toString() ??
                                      ''),
                                ),
                              ],
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
