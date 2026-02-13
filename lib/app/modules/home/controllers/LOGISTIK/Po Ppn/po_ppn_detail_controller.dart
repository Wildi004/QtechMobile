import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/po_ppn/detail.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/po_ppn/po_ppn.dart';

class PoPpnDetailController extends GetxController with Apis {
  PoPpn? data;

  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'no_po',
    'tgl_po',
    'delivery_date',
    'cara_pembayaran',
    'term_from',
    'term_to',
    'lama_hari',
    'jenis_pembayaran',
    'shipment',
    'lokasi_pengiriman',
    'sub_total',
    'tax',
    'catatan',
    'freight_cost',
    'total',
    'kode_proyek',
    'prepared_by_name',
    'suplier_name',
    'dp',
    'jmlDp'
  ]);

  final id = Get.parameters['id'];
  final formatRp =
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
  PoPpn details = PoPpn();
  RxList<DetailPpn> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();
  Future getDetails(PoPpn data) async {
    try {
      String nohide = data.noHide ?? '';
      logg('[DEBUG] Fetch detail dengan noHide: $nohide');

      final res = await api.poPpn.getDataNoHide(nohide);
      details = PoPpn.fromJson(res.data ?? {});
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
      getDetails(data!); // 🚀 otomatis fetch detail
    }
  }
}
