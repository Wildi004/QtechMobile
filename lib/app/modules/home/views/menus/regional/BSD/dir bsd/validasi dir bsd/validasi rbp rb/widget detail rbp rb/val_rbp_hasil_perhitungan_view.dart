import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20rbp%20rb/validasi_rbp_rb_sudah_controller.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class ValRbpHasilPerhitunganView extends GetView<ValidasiRbpRbSudahController> {
  final String? noHide;

  const ValRbpHasilPerhitunganView({
    super.key,
    this.noHide,
  });

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ValidasiRbpRbSudahController());

    final forms = controller.forms;
    if (noHide != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await controller.getDetailByNoHide(noHide!);

        if (controller.detailDatas.isNotEmpty) {
          final data = controller.detailDatas.first;

          forms.fill(data.toJson());
        }
      });
    }

    return Obx(() {
      if (controller.isDetailLoading.value) {
        return CustomLoading();
      }

      if (controller.detailDatas.isEmpty) {
        return const Center(child: Text("Data tidak ditemukan"));
      }

      return SingleChildScrollView(
          padding: Ei.only(t: 10),
          child: Column(
            crossAxisAlignment: Caa.start,
            children: [
              LzForm.input(
                enabled: false,
                label: 'Total Beban Proyek',
                model: forms.key('total_beban_proyek'),
              ),
              LzForm.input(
                enabled: false,
                label: 'Nilai Kontrak',
                model: forms.key('nilai_kontrak'),
                maxLines: 99,
              ),
              LzForm.input(
                enabled: false,
                label: 'PPH',
                model: forms.key('pph'),
                maxLines: 99,
              ),
              LzForm.input(
                enabled: false,
                label: 'Nilai Pendapatan 95%',
                model: forms.key('nilai_pendapatan_95'),
                maxLines: 99,
              ),
              LzForm.input(
                enabled: false,
                label: 'DPP PPH',
                model: forms.key('dpp_pph'),
                maxLines: 99,
              ),
              LzForm.input(
                enabled: false,
                label: 'M Fee Kantor',
                model: forms.key('m_fee_kantor'),
                maxLines: 99,
              ),
              LzForm.input(
                enabled: false,
                label: 'K Fee Kantor',
                model: forms.key('k_fee_kantor'),
                maxLines: 99,
              ),
              LzForm.input(
                enabled: false,
                label: 'Netto',
                model: forms.key('netto'),
                maxLines: 99,
              ),
              LzForm.input(
                enabled: false,
                label: 'Estimasi Laba',
                model: forms.key('estimasi_laba'),
                maxLines: 99,
              ),
              LzForm.input(
                enabled: false,
                label: 'Retensi',
                model: forms.key('retensi'),
                maxLines: 99,
              ),
              LzForm.input(
                enabled: false,
                label: 'Prestasi Laba',
                model: forms.key('prestasi_laba'),
                maxLines: 99,
              ),
            ],
          ));
    });
  }
}
