import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/po_non/detail.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/po_non/po_non.dart';

class PoNonDetailController extends GetxController with Apis {
  PoNon? data;
  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'no_po_nonppn',
    'tgl_po',
    'tgl_dikirim',
    'cara_pembayaran',
    'term_from',
    'term_to',
    'lama_hari',
    'suplier_id',
    'sub_total',
    'freight_cost',
    'total',
    'dp',
    'jml_dp',
    'catatan',
    'prepared_by',
    'status_bsd',
    'validasi_bsd',
    'approved_by',
    'status_dir_keuangan',
    'prepared_by_name',
    'user_session_name',
    'validasi_bsd_name',
    'approved_by_name',
    'suplier_name',
  ]);

  final id = Get.parameters['id'];
  final formatRp =
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
  PoNon details = PoNon();
  RxList<DetailPoNon> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();
  Future getDetails(PoNon data) async {
    try {
      String nohide = data.noHide ?? '';
      logg('[DEBUG] Fetch detail dengan noHide: $nohide');
      logg('[DEBUG] noHide original: ${data.noHide}');
      logg('[DEBUG] noHide encoded: ${Uri.encodeComponent(data.noHide ?? '')}');

      final res = await api.poNon.getDataNoHide(nohide);
      details = PoNon.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];

      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'nama_barang',
          'qty',
          'satuan_name',
          'unit_price',
          'diskon',
          'amount',
        ]);

        final hargaVal = num.tryParse(e.unitPrice.toString()) ?? 0;
        final totalHargaVal = num.tryParse(e.amount.toString()) ?? 0;

        form.fill({
          'nama_barang': e.namaBarang ?? '-',
          'qty': e.qty?.toString() ?? '-',
          'satuan_name': e.satuanName ?? '',
          'unit_price': formatRp.format(hargaVal),
          'diskon': e.diskon?.toString() ?? '',
          'amount': formatRp.format(totalHargaVal),
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
