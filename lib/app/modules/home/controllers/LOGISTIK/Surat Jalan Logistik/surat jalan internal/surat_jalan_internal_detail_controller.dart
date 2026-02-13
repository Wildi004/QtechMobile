import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/surat_jalan_internal/detail.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/surat_jalan_internal/surat_jalan_internal.dart';

class SuratJalanInternalDetailController extends GetxController with Apis {
  SuratJalanInternal? data;

  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'no_bukti',
    'ditujukan',
    'tgl',
    'no_pengajuan',
    'tujuan',
    'kode_proyek',
    'proyek_item_id',
    'nama_proyek',
    'total',
    'keterangan',
    'yang_menyerahkan',
    'status_gm_bali',
    'approval',
    'status_dir',
    'approved_by',
    'sub_total',
    'bag_logistik',
    'ttd'
  ]);

  final id = Get.parameters['id'];
  final formatRp =
      NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
  SuratJalanInternal details = SuratJalanInternal();
  RxList<DetailSuratJalanInternal> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();
  Future getDetails(SuratJalanInternal data) async {
    try {
      String nohide = data.noHide ?? '';
      logg('[DEBUG] Fetch detail dengan noHide: $nohide');
      logg('[DEBUG] data.noHide => ${data.noHide}');
      logg('[DEBUG] Data header: ${details.toJson()}');
      logg('[DEBUG] Jumlah detail: ${details.detail?.length ?? 0}');

      final res = await api.suratJalanInternal.getDataNoHide(nohide);
      details = SuratJalanInternal.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];

      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'kode_material',
          'nama_barang',
          'volume',
          'satuan',
          'uraian',
          'total_harga'
        ]);

        form.fill({
          'kode_material': e.kodeMaterial ?? '',
          'nama_barang': e.namaBarang ?? '',
          'volume': e.volume?.toString() ?? '-',
          'satuan': e.satuan ?? '',
          'uraian': e.uraian ?? '',
          'total_harga': e.totalHarga,
        });

        return form;
      }).toList();
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future getDetailsByNoHide(String noHide) async {
    try {
      isLoading.value = true;
      logg(
          '[DEBUG] Ambil detail surat jalan internal berdasarkan noHide: $noHide');

      final res = await api.suratJalanInternal.getDataNoHide(noHide);
      details = SuratJalanInternal.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];

      // Isi form utama
      forms.fill(details.toJson());

      // Isi form detail
      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'kode_material',
          'nama_barang',
          'volume',
          'satuan',
          'uraian',
          'total_harga'
        ]);

        form.fill({
          'kode_material': e.kodeMaterial ?? '',
          'nama_barang': e.namaBarang ?? '',
          'volume': e.volume?.toString() ?? '-',
          'satuan': e.satuan ?? '',
          'uraian': e.uraian ?? '',
          'total_harga': e.totalHarga,
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

    final args = Get.arguments;
    final String? noInt = args?['noInt'];

    if (data != null) {
      forms.fill(data!.toJson());
      getDetails(data!);
    } else if (noInt != null) {
      getDetailsByNoHide(noInt);
    } else {
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
