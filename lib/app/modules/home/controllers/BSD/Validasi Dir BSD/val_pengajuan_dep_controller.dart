import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/count_notif/count_notif.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20pengajuan%20departemen/pengajuan%20departemen%20hrd/validasi_pengajuan_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20pengajuan%20departemen/pengajuan%20departemen%20it/validasi_pengajuan_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20pengajuan%20departemen/pengajuan%20departemen%20legal/validasi_pengajun_legal_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20pengajuan%20departemen/pengajuan%20departemen%20logistik/validasi_pengajuan_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20pengajuan%20departemen/pengajuan%20departemen%20rnd/validasi_pengajuan_rnd_view.dart';

class ValPengajuanDepController extends GetxController with Apis {
  final dataValidasi = <Map<String, dynamic>>[].obs;

  void onItemTap(int i) {
    switch (i) {
      case 0:
        Get.to(() => ValidasiPengajuanLogistikView())?.then((value) {
          if (value == true) getData();
        });
        break;

      case 1:
        Get.to(() => ValidasiPengajuanItView())?.then((value) {
          if (value == true) getData();
        });
        break;

      case 2:
        Toast.show('Validasi Pengajuan Marketing ditekan');
        break;

      case 3:
        Get.to(() => ValidasiPengajuanHrdView())?.then((value) {
          if (value == true) getData();
        });
        break;

      case 4:
        Get.to(() => ValidasiPengajunLegalView())?.then((value) {
          if (value == true) getData();
        });
        break;

      case 5:
        Get.to(() => ValidasiPengajuanRndView())?.then((value) {
          if (value == true) getData();
        });
        break;

      default:
        Toast.show('Menu belum tersedia');
    }
  }

  RxBool isLoading = true.obs;
  List<CountNotif> listAset = [];
  RxList<CountNotif> aset = <CountNotif>[].obs;

  Future getData() async {
    try {
      isLoading.value = true;

      final res = await api.countNotif.getData();

      final countNotif = CountNotif.fromJson(res.data);

      // simpan ke aset kalau mau
      aset.value = [countNotif];

      // ambil bagian pengajuan_departemen
      final data = countNotif.pengajuanDepartemen;

      if (data != null) {
        dataValidasi.value = [
          {
            'title': 'Validasi Pengajuan Logistik',
            'count': data.pengajuanLogistik ?? 0
          },
          {'title': 'Validasi Pengajuan IT', 'count': data.pengajuanIt ?? 0},
          {'title': 'Validasi Pengajuan Marketing', 'count': 0},
          {'title': 'Validasi Pengajuan HRD', 'count': data.pengajuanHrd ?? 0},
          {
            'title': 'Validasi Pengajuan Legal',
            'count': data.pengajuanLegal ?? 0
          },
          {'title': 'Validasi Pengajuan R&D', 'count': data.pengajuanRnd ?? 0},
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
