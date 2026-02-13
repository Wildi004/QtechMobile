import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/pas_bandara_hrd/pas_bandara_hrd.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/pas%20bandara%20controller/pas_bandara_hrd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/pas%20bandara/detail_orang_pas_bandara_view.dart';
import 'package:qrm_dev/app/widgets/custom_animasi_icon.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class DetailPasBandaraHrdView extends GetView<PasBandaraHrdController> {
  final PasBandaraHrd? data;
  const DetailPasBandaraHrdView({super.key, this.data});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PasBandaraHrdController());
    final forms = controller.forms;
    if (data != null) {
      forms.fill(data!.toJson());
      controller.fillFormDetails(data!.detailOrang);
    }

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(title: 'Detail Pas Bandara').appBar,
      body: Column(
        children: [
          Expanded(
            child: LzListView(
              gap: 15,
              children: [
                LzForm.input(
                  enabled: false,
                  label: 'No Pengajuan',
                  model: forms.key('no_pengajuan'),
                ),
                LzForm.input(
                  enabled: false,
                  label: 'Kode Proyek',
                  model: forms.key('kode_proyek'),
                ),
                LzForm.input(
                  enabled: false,
                  label: 'Proyek Item',
                  model: forms.key('proyek_item_name'),
                ),
                Intrinsic(gap: 10, children: [
                  LzForm.input(
                    enabled: false,
                    label: 'Jenis PAS',
                    model: forms.key('jenis_pas'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'PM ',
                    model: forms.key('pm_name'),
                  ),
                ]),
                Intrinsic(gap: 10, children: [
                  LzForm.input(
                    enabled: false,
                    label: 'Tanggal Pengajuan',
                    model: forms.key('tgl_pengajuan'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Masa Berlaku',
                    model: forms.key('masa_berlaku'),
                  ),
                ]),
                LzForm.input(
                  enabled: false,
                  label: 'Departemen',
                  model: forms.key('dep'),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Nama',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        IconButton(
                                          icon: CustomAnimasiIcon(
                                              icon: Hi.settings01,
                                              color: Colors.black),
                                          onPressed: () {
                                            if (i <
                                                controller
                                                    .detailOrangList.length) {
                                              final orang =
                                                  controller.detailOrangList[i];
                                              Get.to(() =>
                                                  DetailOrangPasBandaraView(
                                                      data: orang));
                                            } else {}
                                          },
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ],
                                    ),
                                    LzForm.input(
                                      enabled: false,
                                      model: form.key('nama'),
                                    ),
                                  ],
                                ),
                                LzForm.input(
                                  label: 'Komentar GM',
                                  enabled: false,
                                  model: form.key('komentar'),
                                ),
                                10.height,
                                statusvalidasiGm('Status', data?.statusGm),
                              ],
                            ),
                          );
                        }),
                      )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
