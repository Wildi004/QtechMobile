import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pemb_non_ppn/detail.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pemb_non_ppn/pemb_non_ppn.dart';

class PembJktNonPpnDetailController extends GetxController with Apis {
  PembNonPpn? data;

  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'no_pembelian_nonppn', //
    'tgl_beli', //
    'no_invoice',
    'shipment', //
    'cara_pembayaran', //
    'term_from', //
    'term_to', //
    'lama_hari', //
    'jenis_pembayaran', //
    'sub_total',
    'diskon_ttl',
    'biaya_kirim',
    'total',
    'prepared_by',
    'approved_by',
    'status_dir_keuangan',
    'prepared_by_name',
    'approved_by_name', //
    'user_session_name',
    'suplier_name', //
  ]);

  final id = Get.parameters['id'];
  final formatRp =
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
  PembNonPpn details = PembNonPpn();
  RxList<DetailPembNon> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();
  Future getDetails(PembNonPpn data) async {
    try {
      String nohide = data.noHide ?? '';
      logg('[DEBUG] Fetch detail dengan noHide: $nohide');

      final res = await api.pembNonPpn.getDataNoHidejkt(nohide);
      details = PembNonPpn.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];

      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'nama_barang',
          'qty',
          'satuan_name',
          'harga_satuan',
          'diskon',
          'total_harga',
        ]);

        final hargaVal = num.tryParse(e.hargaSatuan.toString()) ?? 0;
        final totalHargaVal = num.tryParse(e.totalHarga.toString()) ?? 0;

        form.fill({
          'nama_barang': '${e.kodeMaterial ?? '-'} || ${e.namaBarang ?? '-'}',
          'qty': e.qty?.toString() ?? '-',
          'satuan_name': e.satuanName ?? '',
          'harga_satuan': formatRp.format(hargaVal),
          'diskon': e.diskon?.toString() ?? '',
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

  @override
  void onReady() {
    super.onReady();
    if (data != null) {
      forms.fill(data!.toJson());
      getDetails(data!);
    }
  }
}
