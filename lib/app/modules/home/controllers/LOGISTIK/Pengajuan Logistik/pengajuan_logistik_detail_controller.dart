import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pengajuan_logistik/detail.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pengajuan_logistik/pengajuan_logistik.dart';

class PengajuanLogistikDetailController extends GetxController with Apis {
  PengajuanLogistik? data;
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

  PengajuanLogistik details = PengajuanLogistik();
  RxList<DetailPengajuanLogistik> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();
  Future getDetails(PengajuanLogistik data) async {
    try {
      String nohide = data.noHide ?? '';
      final res = await api.pengajuanGlobal.getLogistikNoHide(nohide);
      details = PengajuanLogistik.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];
      forms.fill(details.toJson());

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
