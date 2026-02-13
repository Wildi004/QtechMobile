import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_pemb_ppn/del_pemb_ppn.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_pemb_ppn/detail.dart';

class DelPembPpnDetailController extends GetxController with Apis {
  DelPembPpn? data;

  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'id',
    'no_delivery',
    'no_pembelian',
    'shipment_date',
    'received_date',
    'ekspedisi',
    'penerima',
    'lokasi_pengiriman',
    'total_berat',
    'harga_ekspedisi',
    'created_by',
    'approval',
    'status_gm_regional',
    'approved_by',
    'status_dir_keuangan',
    'created_at',
    'no_hide',
    'created_by_name',
    'approval_name',
    'approved_by_name',
  ]);

  final id = Get.parameters['id'];
  final formatRp =
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
  DelPembPpn details = DelPembPpn();
  RxList<DetailDelPembPpn> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();
  Future getDetails(DelPembPpn data) async {
    try {
      String nohide = data.noHide ?? '';
      logg('[DEBUG] Fetch detail dengan noHide: $nohide');

      final res = await api.delPembPpn.getDataNoHide(nohide);
      details = DelPembPpn.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];

      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'qty',
          'nama_barang',
          'berat_satuan',
        ]);

        form.fill({
          'qty': e.qty?.toString() ?? '-',
          'nama_barang': e.namaBarang ?? '',
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
