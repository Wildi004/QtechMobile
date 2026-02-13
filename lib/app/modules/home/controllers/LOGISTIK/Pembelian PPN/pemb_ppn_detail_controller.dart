import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pembelian_ppn/detail.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pembelian_ppn/pembelian_ppn.dart';

class PembPpnDetailController extends GetxController with Apis {
  PembelianPpn? data;

  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'no_pembelian',
    'shipment',
    'tgl_beli',
    'no_invoice',
    'cara_pembayaran',
    'term_from',
    'term_to',
    'lama_hari',
    'jenis_pembayaran',
    'suplier_id',
    'sub_total',
    'diskon_ttl',
    'ppn',
    'biaya_kirim',
    'total',
    'prepared_by',
    'approved',
    'status_dir_keuangan',
    'approval',
    'status_gm_regional',
    'prepared_by_name',
    'approved_name',
    'approval_name',
    'suplier_name',
  ]);

  final id = Get.parameters['id'];
  final formatRp =
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
  PembelianPpn details = PembelianPpn();
  RxList<DetailPembPpn> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();
  Future getDetails(PembelianPpn data) async {
    try {
      String nohide = data.noHide ?? '';
      logg('[DEBUG] Fetch detail dengan noHide: $nohide');

      final res = await api.pembPpn.getDataNoHide(nohide);
      details = PembelianPpn.fromJson(res.data ?? {});
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
