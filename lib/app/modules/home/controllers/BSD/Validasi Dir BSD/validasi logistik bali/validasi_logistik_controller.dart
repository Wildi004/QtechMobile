import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/count_notif/count_logistik.dart';
import 'package:qrm_dev/app/data/models/count_notif/count_notif.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20bali/validasi%20del%20pemb%20non%20ppn/validasi_del_pemb_non_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20bali/validasi%20del%20pemb%20ppn/validasi_del_pemb_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20bali/validasi%20del%20po%20non%20ppn/validasi_del_po_non_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20bali/validasi%20del%20po%20ppn/validasi_del_po_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20bali/validasi%20inv%20del%20pemb%20non%20ppn/validasi_inv_del_pemb_non_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20bali/validasi%20inv%20del%20pemb%20ppn/validasi_inv_del_pemb_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20bali/validasi%20inv%20del%20po%20non%20ppn/validasi_inv_del_del_po_non_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20bali/validasi%20inv%20del%20po%20ppn/validasi_inv_del_po_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20bali/validasi%20pembelian%20ppn/validasi_pemb_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20bali/validasi%20po%20non%20ppn/validasi_po_non_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20bali/validasi%20po%20ppn/validasi_po_ppn_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20bali/validasi%20surat%20jalan%20eksternal%20bali/validasi_sj_eks_bali_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20bali/validasi%20surat%20jalan%20eksternal%20non%20ppn%20bali/validasi_sj_eks_non_bali_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20bali/validasi%20surat%20jalan%20internal%20bali/validasi_sj_in_bali_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20logistik%20jakarta/validasi%20surat%20jalan%20internal%20jakarta/validasi_sj_in_jkt_view.dart';

class ValidasiLogistikController extends GetxController with Apis {
  final dataValidasi = <Map<String, dynamic>>[].obs;

  void onItemTap(int i) {
    switch (i) {
      case 0:
        Toast.show('Validasi Alat Proyek Bali');
        break;

      case 1:
        Toast.show('Validasi Alat Proyek Jakarta');
        break;

      case 2:
        Get.to(() => ValidasiDelPembNonPpnView())!.then((value) {
          if (value == true) {
            getData();
          }
        });
        break;

      case 3:
        Get.to(() => ValidasiDelPembPpnView())!.then((value) {
          if (value == true) {
            getData();
          }
        });
        break;

      case 4:
        Get.to(() => ValidasiDelPoNonPpnView())!.then((value) {
          if (value == true) {
            getData();
          }
        });
        break;

      case 5:
        Get.to(() => ValidasiDelPoPpnView())!.then((value) {
          if (value == true) {
            getData();
          }
        });
        break;

      case 6:
        Get.to(() => ValidasiInvDelPembNonPpnView())!.then((value) {
          if (value == true) {
            getData();
          }
        });
        break;

      case 7:
        Get.to(() => ValidasiInvDelPembPpnView())!.then((value) {
          if (value == true) {
            getData();
          }
        });
        break;

      case 8:
        Get.to(() => ValidasiInvDelDelPoNonPpnView())!.then((value) {
          if (value == true) {
            getData();
          }
        });
        break;

      case 9:
        Get.to(() => ValidasiInvDelPoPpnView())!.then((value) {
          if (value == true) {
            getData();
          }
        });
        break;

      case 10:
        Get.to(() => ValidasiPembPpnView())!.then((value) {
          if (value == true) {
            getData();
          }
        });
        break;

      case 11:
        Get.to(() => ValidasiPoNonPpnView())!.then((value) {
          if (value == true) {
            getData();
          }
        });
        break;

      case 12:
        Get.to(() => ValidasiPoPpnView())!.then((value) {
          if (value == true) {
            getData();
          }
        });
        break;

      case 13:
        Toast.show('Validasi Retur Material Proyek');
        break;

      case 14:
        Get.to(() => ValidasiSjEksBaliView())!.then((value) {
          if (value == true) {
            getData();
          }
        });
        break;

      case 15:
        Toast.show('Validasi Surat Jalan Eksternal Jakarta');
        break;

      case 16:
        Get.to(() => ValidasiSjEksNonBaliView())!.then((value) {
          if (value == true) {
            getData();
          }
        });
        break;

      case 17:
        Toast.show('Validasi Surat Jalan Eksternal Non PPN Jakarta');
        break;

      case 18:
        Get.to(() => ValidasiSjInBaliView())!.then((value) {
          if (value == true) {
            getData();
          }
        });
        break;

      case 19:
        Get.to(() => ValidasiSjInJktView())!.then((value) {
          if (value == true) {
            getData();
          }
        });
        break;
      default:
        Toast.show('Menu belum tersedia');
    }
  }

  RxBool isLoading = true.obs;
  List<LogistikCount> listAset = [];
  RxList<LogistikCount> aset = <LogistikCount>[].obs;

  Future getData() async {
    try {
      isLoading.value = true;

      final res = await api.countNotif.getData();

      final countNotif = CountNotif.fromJson(res.data);

      if (countNotif.logistik != null) {
        aset.value = [countNotif.logistik!];
      }

      final data = countNotif.logistik;

      if (data != null) {
        dataValidasi.value = [
          {
            'title': 'Validasi Alat Proyek Bali',
            'count': data.alatProyekBali ?? 0
          },
          {
            'title': 'Validasi Alat Proyek Jakarta',
            'count': data.alatProyekJakarta ?? 0
          },
          {
            'title': 'Validasi Delivery Material Pembelian Non PPN',
            'count': data.deliveryMaterialPembelianNonPpn ?? 0
          },
          {
            'title': 'Validasi Delivery Material Pembelian PPN',
            'count': data.deliveryMaterialPembelianPpn ?? 0
          },
          {
            'title': 'Validasi Delivery Material PO Non PPN',
            'count': data.deliveryMaterialPoNonPpn ?? 0
          },
          {
            'title': 'Validasi Delivery Material PO PPN',
            'count': data.deliveryMaterialPoPpn ?? 0
          },
          {
            'title': 'Validasi Invoice Delivery Material Pembelian Non PPN',
            'count': data.invDeliveryMaterialPembelianNonPpn ?? 0
          },
          {
            'title': 'Validasi Invoice Delivery Material Pembelian PPN',
            'count': data.invDeliveryMaterialPembelianPpn ?? 0
          },
          {
            'title': 'Validasi Invoice Delivery Material PO Non PPN',
            'count': data.invDeliveryMaterialPoNonPpn ?? 0
          },
          {
            'title': 'Validasi Invoice Delivery Material PO PPN',
            'count': data.invDeliveryMaterialPoPpn ?? 0
          },
          {'title': 'Validasi Pembelian PPN', 'count': data.pembelianPpn ?? 0},
          {'title': 'Validasi PO Non PPN', 'count': data.poNonPpn ?? 0},
          {'title': 'Validasi PO PPN', 'count': data.poPpn ?? 0},
          {
            'title': 'Validasi Retur Material Proyek',
            'count': data.returMaterialProyek ?? 0
          },
          {
            'title': 'Validasi Surat Jalan Eksternal Bali',
            'count': data.suratJalanEksternalBali ?? 0
          },
          {
            'title': 'Validasi Surat Jalan Eksternal Jakarta',
            'count': data.suratJalanEksternalJakarta ?? 0
          },
          {
            'title': 'Validasi Surat Jalan Eksternal Non PPN Bali',
            'count': data.suratJalanEksternalNonPpnBali ?? 0
          },
          {
            'title': 'Validasi Surat Jalan Eksternal Non PPN Jakarta',
            'count': data.suratJalanEksternalNonPpnJakarta ?? 0
          },
          {
            'title': 'Validasi Surat Jalan Internal Bali',
            'count': data.suratJalanInternalBali ?? 0
          },
          {
            'title': 'Validasi Surat Jalan Internal Jakarta',
            'count': data.suratJalanInternalJakarta ?? 0
          },
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
