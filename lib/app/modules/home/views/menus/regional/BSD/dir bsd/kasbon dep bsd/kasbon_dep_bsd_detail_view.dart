import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/kasbon_dep_bsd/kasbon_dep_bsd.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Kasbon%20Dev%20Bsd/kasbon_dep_bsd_detail_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/pengajuan%20it/cetak%20pengajuan/cetak_pengajuan_it_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class KasbonDepBsdDetailView extends GetView<KasbonDepBsdDetailController> {
  final KasbonDepBsd? data;
  final bool showPrintButton;

  const KasbonDepBsdDetailView({
    super.key,
    this.data,
    this.showPrintButton = false,
  });

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => KasbonDepBsdDetailController());

    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      controller.getDetails(data!);
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppbar(
          title: 'Detail Kasbon BSD',
          actions: [
            if (showPrintButton)
              IconButton(
                onPressed: () {
                  final cetakController = Get.put(CetakPengajuanItView());
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
                          gap: 10,
                          children: [
                            LzForm.input(
                              label: 'Departemen',
                              enabled: false,
                              model: form.key('nama_pengajuan'),
                            ),
                            LzForm.input(
                              label: 'Tgl. Kasbon',
                              enabled: false,
                              model: form.key('tgl_kasbon'),
                            ),
                            LzForm.input(
                              label: 'No. Pengajuan',
                              enabled: false,
                              model: form.key('no_pengajuan'),
                            ),
                            LzForm.input(
                              label: 'Keterangan',
                              enabled: false,
                              model: form.key('keterangan'),
                            ),
                            LzForm.input(
                              label: 'Total Harga',
                              enabled: false,
                              model: form.key('total_harga'),
                            ),
                          ],
                        );
                      }),
                      Intrinsic(
                        children: [
                          Text('Acc Dir. Keu'),
                          statusValidasiRow(
                            '',
                            int.tryParse(
                                data?.statusDirKeuangan?.toString() ?? ''),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
