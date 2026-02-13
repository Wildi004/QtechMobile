import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/pengajuan%20global/pengajuan%20sudah%20validasi/pengajuan_sudah_validasi/detail.dart';
import 'package:qrm_dev/app/data/models/pengajuan%20global/pengajuan%20sudah%20validasi/pengajuan_sudah_validasi/pengajuan_sudah_validasi.dart';

class DetailPengajuanHrdController extends GetxController with Apis {
  PengajuanSudahValidasi? data;
  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'no_pengajuan',
    'sub_total',
    "tgl_pengajuan",
    "item_id",
    "rab_id",
    "nama_barang",
    "qty",
    "harga",
    'dep_name',
    'jenis_rab',
  ]);

  final id = Get.parameters['id'];

  PengajuanSudahValidasi details = PengajuanSudahValidasi();
  RxList<DetailValidasi> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();
  Future getDetails(PengajuanSudahValidasi data) async {
    try {
      String nohide = data.noHide ?? '';

      final res = await api.pengajuanGlobal.getDataHrdByNoHide(nohide);
      details = PengajuanSudahValidasi.fromJson(res.data ?? {});

      forms.fill(details.toJson());

      cards.value = details.detail ?? [];

      final formatRp =
          NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'jenis_rab',
          'nama_barang',
          'qty',
          'harga',
          'total_harga',
        ]);

        final hargaVal = (e.harga ?? '');
        final totalHargaVal = (e.totalHarga ?? '');

        form.fill({
          'jenis_rab': e.jenisRab ?? '-',
          'nama_barang': e.namaBarang ?? '-',
          'qty': e.qty ?? '',
          'harga': formatRp.format(hargaVal),
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
}
