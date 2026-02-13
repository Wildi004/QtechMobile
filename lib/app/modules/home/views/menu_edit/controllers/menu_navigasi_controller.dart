import 'package:get/get.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/modules/brosur_logistik/views/brosur_logistik_view.dart';
import 'package:qrm_dev/app/modules/daftar_tkdn/views/daftar_tkdn_view.dart';
import 'package:qrm_dev/app/modules/data_mandor/views/data_mandor_view.dart';
import 'package:qrm_dev/app/modules/harga_modal_logistik/views/harga_modal_logistik_view.dart';
import 'package:qrm_dev/app/modules/job_desk/views/job_desk_view.dart';
import 'package:qrm_dev/app/modules/kasbon/views/kasbon_view.dart';
import 'package:qrm_dev/app/modules/monitoring_proyek/views/monitor_view.dart';
import 'package:qrm_dev/app/modules/panduan_instalasi/views/panduan_instalasi_view.dart';
import 'package:qrm_dev/app/modules/pengumuman/views/pengumuman_view.dart';
import 'package:qrm_dev/app/modules/standar_teknik/views/standar_teknik_view.dart';
import 'package:qrm_dev/app/modules/surat_direksi/views/surat_direksi_view.dart';
import 'package:qrm_dev/app/modules/surat_internal/views/surat_internal_view.dart';
import 'package:qrm_dev/app/routes/app_pages.dart';

import '../../../../capaian_kinerja/views/capaian_kerja1/capaian_kerja1_view.dart';

class MenuNavigasiController {
  void navigateTo(String routeKey) {
    switch (routeKey) {
      case 'kasbon':
        Get.to(() => KasbonView());
        break;
      case 'capaian_kinerja':
        Get.context!.openBottomSheet(CapaianKerja1View());
        break;
      case 'modal_logistik':
        Get.to(() => HargaModalLogistikView());
        break;
      case 'notulen':
        Get.toNamed(Routes.NOTULEN);
        break;
      case 'anggaran_departemen':
        Get.toNamed(Routes.ANGGARAN_DEPARTEMEN);
        break;
      case 'monitoring_project':
        Get.to(() => MonitorView());
        break;
      case 'brosur_logistik':
        Get.context!.openBottomSheet(BrosurLogistikView());
        break;
      case 'daftar_tkdn':
        Get.context!.openBottomSheet(DaftarTkdnView());
        break;
      case 'surat_internal':
        Get.context!.openBottomSheet(SuratInternalView());
        break;
      case 'job_desk':
        Get.context!.openBottomSheet(JobDeskView());
        break;
      case 'sk_direksi':
        Get.context!.openBottomSheet(SuratDireksiView());
        break;
      case 'data_mandor':
        Get.context!.openBottomSheet(DataMandorView());
        break;
      case 'panduan_instalasi':
        Get.context!.openBottomSheet(PanduanInstalasiView());
        break;
      case 'pengumuman':
        Get.context!.openBottomSheet(PengumumanView());
        break;
      case 'Standar_teknik':
        Get.context!.openBottomSheet(StandarTeknikView());
        break;
      default:
        break;
    }
  }
}
