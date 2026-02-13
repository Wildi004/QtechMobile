import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_po_ppn/del_po_ppn.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_po_ppn/detail.dart';

class DelPoPpnDetailController extends GetxController with Apis {
  DelPoPpn? data;

  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'id',
    'no_delivery', //
    'no_po', //
    'shipment_date', //
    'received_date', //
    'lokasi_kirim', //
    'penerima', //
    'ekspedisi', //
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
  DelPoPpn details = DelPoPpn();
  RxList<DetailDelpoPpn> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();
  Future getDetails(DelPoPpn data) async {
    try {
      String nohide = data.noHide ?? '';
      logg('[DEBUG] Fetch detail dengan noHide: $nohide');

      final res = await api.delPoPpn.getDataNoHide(nohide);
      details = DelPoPpn.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];

      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'kode_material',
          'qty',
          'nama_barang',
          'jumlah_keluar',
          'berat_satuan',
          'total',
        ]);

        final totalHargaVal = num.tryParse(e.total.toString()) ?? 0;

        form.fill({
          'kode_material': e.kodeMaterial ?? '-',
          'qty': e.qty?.toString() ?? '-',
          'nama_barang': e.namaBarang ?? '',
          'jumlah_keluar': e.jumlahKeluar?.toString() ?? '-',
          'berat_satuan': e.beratSatuan?.toString() ?? '',
          'total': formatRp.format(totalHargaVal),
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
  void onInit() {
    super.onInit();

    // Ambil argument dari navigasi
    final args = Get.arguments;
    final String? noHide = args?['no_hide'];

    if (data != null) {
      forms.fill(data!.toJson());
      getDetails(data!);
    } else if (noHide != null) {
      fetchDataByNoHide(noHide);
    } else {
      isLoading.value = false;
    }
  }

  Future<void> fetchDataByNoHide(String noHide) async {
    try {
      isLoading.value = true;
      logg('[DEBUG] Ambil Delivery PO PPN berdasarkan noHide: $noHide');

      final res = await api.delPoPpn.getDataNoHide(noHide);
      details = DelPoPpn.fromJson(res.data ?? {});
      data = details;

      // isi data header
      forms.fill(details.toJson());

      // isi detail barang
      cards.value = details.detail ?? [];
      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'kode_material',
          'qty',
          'nama_barang',
          'jumlah_keluar',
          'berat_satuan',
          'total',
        ]);

        final totalHargaVal = num.tryParse(e.total.toString()) ?? 0;
        form.fill({
          'kode_material': e.kodeMaterial ?? '-',
          'qty': e.qty?.toString() ?? '-',
          'nama_barang': e.namaBarang ?? '',
          'jumlah_keluar': e.jumlahKeluar?.toString() ?? '-',
          'berat_satuan': e.beratSatuan?.toString() ?? '',
          'total': formatRp.format(totalHargaVal),
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
