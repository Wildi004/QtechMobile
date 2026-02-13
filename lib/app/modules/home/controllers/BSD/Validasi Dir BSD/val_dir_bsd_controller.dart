import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/count_notif/count_notif.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20cuti/validasi_cuti_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20kasbon/validasi_kasbon_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20bali/validasi_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20pengajuan%20departemen/val_pengajuan_dep_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20ptj/validasi_ptj_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20rab%20departemen/validasi_rab_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20rbp%20rb/validasi_rbp_rb_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20rbp%20rj/validasi_rbp_rj_view.dart';

class ValDirBsdController extends GetxController with Apis {
  final dataValidasi = <Map<String, dynamic>>[
    {'title': 'Validasi Cuti', 'count': 23},
    {'title': 'Validasi Kasbon', 'count': 36},
    {'title': 'Validasi Laporan Kerja Harian', 'count': 3001},
    {'title': 'Validasi Logistik', 'count': 256},
    {'title': 'Validasi Pengajuan Departement', 'count': 0},
    {'title': 'Validasi Pengajuan Gaji (Bali)', 'count': 4},
    {'title': 'Validasi Pengajuan Gaji (Jakarta)', 'count': 0},
    {'title': 'Validasi Pengajuan Tenaga Kerja RB (PM)', 'count': 0},
    {'title': 'Validasi Pengajuan Tenaga Kerja RT (PM)', 'count': 1},
    {'title': 'Validasi PTJ', 'count': 0},
    {'title': 'Validasi RAB Departemen', 'count': 0},
    {'title': 'Validasi RBP (Bali)', 'count': 0},
    {'title': 'Validasi RBP (Jakata)', 'count': 0},
    {'title': 'Validasi Store', 'count': 0},
    {'title': 'Validasi Surat Keluar', 'count': 0},
  ].obs;

  RxBool isLoading = true.obs;

  Future getData() async {
    try {
      isLoading.value = true;
      final res = await api.countNotif.getData();

      final countNotif = CountNotif.fromJson(res.data);
      final data = countNotif.pengajuanDepartemen;

      if (data != null) {
        int total = data.pengajuanTotal ?? 0;

        for (int i = 0; i < dataValidasi.length; i++) {
          if (dataValidasi[i]['title'] == 'Validasi Pengajuan Departement') {
            dataValidasi[i]['count'] = total;
            break;
          }
        }
        final ptj = countNotif.ptjDepartemen;
        if (ptj != null) {
          int totalPtj = ptj.ptjTotal ?? 0;

          // update count untuk Validasi PTJ
          for (int i = 0; i < dataValidasi.length; i++) {
            if (dataValidasi[i]['title'] == 'Validasi PTJ') {
              dataValidasi[i]['count'] = totalPtj;
              break;
            }
          }
        }

        final logistik = countNotif.logistik;
        if (logistik != null) {
          int totalLogistik = logistik.total ?? 0;

          for (int i = 0; i < dataValidasi.length; i++) {
            if (dataValidasi[i]['title'] == 'Validasi Logistik') {
              dataValidasi[i]['count'] = totalLogistik;
              break;
            }
          }
        }

        final rab = countNotif.rabDepartemen;
        if (rab != null) {
          int totalRab = rab.rabDepartemen ?? 0;

          for (int i = 0; i < dataValidasi.length; i++) {
            if (dataValidasi[i]['title'] == 'Validasi RAB Departemen') {
              dataValidasi[i]['count'] = totalRab;
              break;
            }
          }
        }

        dataValidasi.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void onItemTap(int i) {
    if (i == 0) {
      Get.to(() => ValidasiCutiView())!.then((value) {
        if (value == true) {
          getData();
        }
      });
    } else if (i == 1) {
      Get.to(() => ValidasiKasbonView())!.then((value) {
        if (value == true) {
          getData();
        }
      });
    } else if (i == 11) {
      Get.to(() => ValidasiRbpRbView())!.then((value) {
        if (value == true) {
          getData();
        }
      });
    } else if (i == 12) {
      Get.to(() => ValidasiRbpRjView())!.then((value) {
        if (value == true) {
          getData();
        }
      });
    } else if (i == 2) {
      Toast.show('Validasi Laporan Kerja Harian dalam pengembangan');
    } else if (i == 4) {
      Get.to(() => ValPengajuanDepView())!.then((value) {
        if (value == true) {
          getData();
        }
      });
    } else if (i == 5) {
      Toast.show('Validasi Pengajuan Gaji (Bali) dalam pengembangan');
    } else if (i == 6) {
      Toast.show('Validasi Pengajuan Gaji (Jakarta) dalam pengembangan');
    } else if (i == 7) {
      Toast.show('Validasi Tenaga Kerja RB (PM) dalam pengembangan');
    } else if (i == 8) {
      Toast.show('Validasi Tenaga Kerja RT (PM) dalam pengembangan');
    } else if (i == 9) {
      Get.to(() => ValidasiPtjView())!.then((value) {
        if (value == true) {
          getData();
        }
      });
    } else if (i == 3) {
      Get.to(() => ValidasiLogistikView())!.then((value) {
        if (value == true) {
          getData();
        }
      });
    } else if (i == 10) {
      Get.to(() => ValidasiRabView())!.then((value) {
        if (value == true) {
          getData();
        }
      });
    } else {
      Toast.show('Menu belum tersedia');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
