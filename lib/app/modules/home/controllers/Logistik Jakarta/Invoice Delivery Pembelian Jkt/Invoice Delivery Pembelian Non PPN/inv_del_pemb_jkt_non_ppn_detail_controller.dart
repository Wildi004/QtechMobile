import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/inv_del_pemb_non_ppn/detail.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/inv_del_pemb_non_ppn/inv_del_pemb_non_ppn.dart';

class InvDelPembJktNonPpnDetailController extends GetxController with Apis {
  InvDelPembNonPpn? data;
  final isFilled = false.obs;
  RxBool isLoading = true.obs;
  final forms = LzForm.make([
    'id',
    'no_invoice',
    'tgl_inv',
    'tgl_dibuat',
    'suplier_id',
    'cara_pembayaran',
    'term_from',
    'term_to',
    'lama_hari',
    'no_delivery',
    'sub_total',
    'ppn',
    'jml_ppn',
    'grandtotal',
    'no_hide',
    'catatan',
    'created_by',
    'status_gm',
    'approval',
    'status_dir_keuangan',
    'approved_by',
    'image',
    'approval_name',
    'approved_by_name',
    'suplier_name',
  ]);

  final id = Get.parameters['id'];

  final formatRp =
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

  InvDelPembNonPpn details = InvDelPembNonPpn();
  RxList<DetailInvDelPembNonPpn> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();
  Future getDetails(InvDelPembNonPpn data) async {
    try {
      String nohide = data.noHide ?? '';

      final res = await api.invDelPembNonPpn.getDataNoHideJkt(nohide);
      details = InvDelPembNonPpn.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];

      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'id',
          'no_hide',
          'no_delivery',
          'kode_material',
          'kode_str',
          'nama_barang',
          'qty',
          'harga_satuan',
          'total_harga',
          'status_jurnal',
        ]);

        final hargaVal = num.tryParse(
                e.hargaSatuan?.replaceAll(RegExp(r'[^0-9.]'), '') ?? '0') ??
            0;
        final totalHargaVal = num.tryParse(
                e.totalHarga?.replaceAll(RegExp(r'[^0-9.]'), '') ?? '0') ??
            0;

        logg(hargaVal);
        form.fill({
          'kode_material': e.kodeMaterial ?? '-',
          'nama_barang': e.namaBarang ?? '-',
          'qty': e.qty?.toString() ?? '-',
          'harga_satuan': formatRp.format(hargaVal),
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
