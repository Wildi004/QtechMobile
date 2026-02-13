import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/count_notif/count_notif.dart';
import 'package:qrm_dev/app/data/models/count_notif/ptj_departemen.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20pengajuan%20departemen/pengajuan%20departemen%20hrd/pengajuan_hrd_belum_valid_veiw.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20pengajuan%20departemen/pengajuan%20departemen%20it/pengajuan_it_belum_valid_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20pengajuan%20departemen/pengajuan%20departemen%20legal/pengajuan_legal_belum_valid_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20ptj/validasi%20ptj%20logistik/validasi_ptj_logistik_view.dart';

class ValidasiPtjItController extends GetxController with Apis {
  final dataValidasi = <Map<String, dynamic>>[].obs;

  void onItemTap(int i) {
    switch (i) {
      case 0:
        Get.to(() => ValidasiPtjLogistikView())?.then((value) {
          if (value == true) getData();
        });
        break;

      case 1:
        Get.to(() => PengajuanItBelumValidView())?.then((value) {
          if (value == true) getData();
        });
        break;

      case 2:
        Toast.show('Validasi Pengajuan Marketing ditekan');
        break;

      case 3:
        Get.to(() => PengajuanHrdBelumValidVeiw())?.then((value) {
          if (value == true) getData();
        });
        break;

      case 4:
        Get.to(() => PengajuanLegalBelumValidView())?.then((value) {
          if (value == true) getData();
        });
        break;

      case 5:
        Toast.show('Validasi Pengajuan R&D ditekan');
        break;

      default:
        Toast.show('Menu belum tersedia');
    }
  }

  RxBool isLoading = true.obs;
  List<PtjDepartemen> listAset = [];
  RxList<PtjDepartemen> aset = <PtjDepartemen>[].obs;

  Future getData() async {
    try {
      isLoading.value = true;

      final res = await api.countNotif.getData();

      final countNotif = CountNotif.fromJson(res.data);

      if (countNotif.ptjDepartemen != null) {
        aset.value = [countNotif.ptjDepartemen!];
      }

      final data = countNotif.ptjDepartemen;

      if (data != null) {
        dataValidasi.value = [
          {'title': 'Validasi PTJ Logistik', 'count': data.ptjLogistik ?? 0},
          {'title': 'Validasi PTJ IT', 'count': data.ptjIt ?? 0},
          {'title': 'Validasi PTJ Marketing', 'count': 0},
          {'title': 'Validasi PTJ HRD', 'count': data.ptjHrd ?? 0},
          {'title': 'Validasi PTJ Legal', 'count': data.ptjLegal ?? 0},
          {'title': 'Validasi PTJ R&D', 'count': 0},
        ];
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
