import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/surat_jalan_exst_non/detail.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/surat_jalan_exst_non/surat_jalan_exst_non.dart';

class SuratJalanExstNonDetailController extends GetxController with Apis {
  SuratJalanExstNon? data;

  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'id',
    'no_bukti',
    'vendor_id',
    'tgl',
    'jenis_sj',
    'no_po',
    'no_kontrak',
    'no_nota',
    'nama_proyek',
    'alamat_kirim',
    'keterangan',
    'status_gm_bali',
    'approval',
    'status_dir',
    'approved_by',
    'bag_pengiriman',
    'penyerah',
    'penerima',
    'created_by',
    'no_hide',
    'created_at',
    'no_po_nonppn',
    'inv_no_nota',
    'proyek_no_kontrak',
    'nama_perusahaan',
    'bag_logistik',
    'ttd',
    'pembuat',
  ]);

  final id = Get.parameters['id'];
  final formatRp =
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
  SuratJalanExstNon details = SuratJalanExstNon();
  RxList<DetailExstNon> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();

  Future getDetails(SuratJalanExstNon data) async {
    try {
      String nohide = data.noHide ?? '';
      logg('[DEBUG] Fetch detail dengan noHide: $nohide');

      final res = await api.suratJalanExstNon.getDataNoHide(nohide);
      details = SuratJalanExstNon.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];

      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'kode_material',
          'nama_barang',
          'volume',
          'satuan',
          'uraian',
        ]);

        form.fill({
          'kode_material': e.kodeMaterial ?? '',
          'nama_barang': e.namaBarang ?? '',
          'volume': e.volume?.toString() ?? '-',
          'satuan': e.satuan ?? '',
          'uraian': e.uraian ?? '',
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
