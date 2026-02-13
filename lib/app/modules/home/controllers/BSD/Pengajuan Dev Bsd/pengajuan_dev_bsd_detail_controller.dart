import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/pengajuan_dep_bsd/detail.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/pengajuan_dep_bsd/pengajuan_dep_bsd.dart';
import 'package:qrm_dev/app/data/models/model%20legal/pengajuan_legal/pengajuan_legal.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pengajuan_logistik/pengajuan_logistik.dart';
import 'package:qrm_dev/app/data/models/models%20it/pengajuan_it/pengajuan_it.dart';
import 'package:qrm_dev/app/data/models/pengajuan%20global/pengajuan%20sudah%20validasi/pengajuan_sudah_validasi/pengajuan_sudah_validasi.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/pengajuan_hrd/detail_pengajuan_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/pengajuan%20it/detail_pengajuan_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/pengajuan%20legal/pengajuan_legal_detail_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/pengajuan%20logistik/pengajuan_logistik_detail_view.dart';

class PengajuanDevBsdDetailController extends GetxController with Apis {
  PengajuanDepBsd? data;
  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'no_pengajuan_reg',
    'tgl_pengajuan',
    'dep_id',
    'regional_id',
    'total',
    'status_dir_keuangan',
    'approved_by',
    'no_hide',
    'type',
    'updated_by',
    'created_name',
    'dep_name',
    'regional_name',
    'no_pengajuan_dep',
  ]);

  final id = Get.parameters['id'];

  PengajuanDepBsd details = PengajuanDepBsd();
  RxList<DetailPengajuanBsd> cards = RxList([]);
  RxList<PengajuanDepBsd> card1 = RxList([]);

  RxList<FormManager> formDetails = RxList<FormManager>();
  Future getDetails(PengajuanDepBsd data) async {
    try {
      String nohide = data.noHide ?? '';
      final res = await api.pengajuanDepBsd.getDataNoHide(nohide);
      details = PengajuanDepBsd.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];
      final formatRp =
          NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'nama_pengajuan',
          'no_pengajuan_dep',
          'total_harga',
        ]);

        // logg('qty: ${e.qty}  ');
        // logg('harga_satuan: ${e.harga} (${e.harga.runtimeType})');
        logg('total_harga: ${e.totalHarga} (${e.totalHarga.runtimeType})');

        // final hargaVal = (e.harga ?? '');
        final totalHargaVal = (e.totalHarga ?? '');

        form.fill({
          'nama_pengajuan': e.namaPengajuan ?? '-',
          'no_pengajuan_dep': e.nomorPengajuanDepartemen ?? '-',
          'total_harga': formatRp.format(totalHargaVal),
        });

        return form;
      }).toList();
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  void openDetail(DetailPengajuanBsd item) {
    final nama = (item.namaPengajuan ?? '').toLowerCase();
    final noDep = item.noPengajuanDep ?? '';

    if (noDep.isEmpty) {
      Toast.warning('Nomor pengajuan departemen tidak ditemukan!');
      return;
    }

    if (nama.contains('hrd')) {
      Get.to(() => DetailPengajuanHrdView(
            data: PengajuanSudahValidasi(noHide: noDep),
            showPrintButton: true,
          ));
    } else if (nama.contains('logistik')) {
      Get.to(() => PengajuanLogistikDetailView(
            data: PengajuanLogistik(noHide: noDep),
            showPrintButton: true,
          ));
    } else if (nama.contains('legal')) {
      Get.to(() => PengajuanLegalDetailView(
            data: PengajuanLegal(noHide: noDep),
            showPrintButton: true,
          ));
    } else if (nama.contains('it')) {
      Get.to(() => DetailPengajuanItView(
            data: PengajuanIt(noHide: noDep),
            showPrintButton: true,
          ));
    }
  }
}
