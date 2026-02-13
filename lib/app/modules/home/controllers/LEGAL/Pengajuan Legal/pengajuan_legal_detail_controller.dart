import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20legal/pengajuan_legal/detail.dart';
import 'package:qrm_dev/app/data/models/model%20legal/pengajuan_legal/pengajuan_legal.dart';

class PengajuanLegalDetailController extends GetxController with Apis {
  PengajuanLegal? data;
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

  PengajuanLegal details = PengajuanLegal();
  RxList<DetailPengajuanLegal> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();
  Future getDetails(PengajuanLegal data) async {
    try {
      String nohide = data.noHide ?? '';
      final res = await api.pengajuanGlobal.getDataLEgalByNoHide(nohide);
      details = PengajuanLegal.fromJson(res.data ?? {});
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

        logg('qty: ${e.qty}  ');
        logg('harga_satuan: ${e.harga} (${e.harga.runtimeType})');
        logg('total_harga: ${e.totalHarga} (${e.totalHarga.runtimeType})');

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
