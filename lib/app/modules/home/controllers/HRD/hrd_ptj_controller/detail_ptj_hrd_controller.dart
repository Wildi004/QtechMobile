import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/ptj_hrd/detail_ptj.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/ptj_hrd/ptj_hrd.dart';
import 'package:qrm_dev/app/data/models/saldo_ptj.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/arsiv/arsip_karyawan/file%20view/file_view.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class DetailPtjHrdController extends GetxController with Apis {
  PtjHrd? data;
  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'id',
    'no_ptj',
    'tgl_ptj',
    'total',
    'status_dir_keuangan',
    'status_gm_bsd',
    'created_at',
    'no_hide',
    'type',
    'created_name',
    'approved_name',
    'saldo',
    'approval_name',
    'dep_name',
    'id',
    'no_ptj',
    'tgl_beli',
    'nama_barang',
    'qty',
    'harga_satuan',
    'total_harga',
    'image',
    'status_acc',
    'status_acc_dir',
    'status_acc_dirut',
    'komentar_dirut',
    'komentar',
    'komentar_dir',
    'created_at',
    'no_hide',
    'adendum',
    'proyek_item_name',
    'detail_pengajuan_name',
    'akun_name',
    'perkiraan_name',
  ]);

  RxList<FormManager> formRabs = RxList([]);

  final id = Get.parameters['id'];

  PtjHrd details = PtjHrd();
  RxList<DetailPtj> cards = RxList([]);

  RxList<FormManager> formDetails = RxList<FormManager>();

  Future getDetails(PtjHrd data) async {
    try {
      String nohide = data.noHide ?? '';
      final res = await api.ptjGlobal.getDataByNoHidePtjHrd(nohide);
      details = PtjHrd.fromJson(res.data ?? {});
      cards.value = details.detailPtj ?? [];

      final formatRp =
          NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'nama_barang',
          'tgl_beli',
          'image',
          'qty',
          'harga_satuan',
          'total_harga',
        ]);

        final hargaSatuanVal = int.tryParse(e.hargaSatuan ?? '') ?? 0;
        final totalHargaVal = int.tryParse(e.totalHarga ?? '') ?? 0;

        form.fill({
          'nama_barang': e.namaBarang ?? '-',
          'tgl_beli': e.tglBeli ?? '-',
          'image': e.image ?? '-',
          'qty': e.qty ?? '',
          'harga_satuan': formatRp.format(hargaSatuanVal),
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

  Future<void> openFileWithTokenAndShowViewer(String fileUrl) async {
    try {
      Get.dialog(
        const CustomLoading(),
        barrierDismissible: false,
      );

      final token = await storage.read('token');
      if (token == null) {
        Get.back(); // Tutup dialog loading
        Toast.show('Token tidak ditemukan');
        return;
      }

      final uri = Uri.parse(fileUrl);
      final response = await http.get(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        final contentType = response.headers['content-type'] ?? '';
        final isPdf = contentType.contains('application/pdf');
        final isImage = contentType.contains('image/');

        if (!isPdf && !isImage) {
          Get.back(); // Tutup dialog loading
          Toast.show('Format file tidak didukung untuk pratinjau');
          return;
        }

        Get.back(); // Tutup dialog loading SEBELUM pindah halaman
        Get.to(() => FileViewerPage(
              fileBytes: bytes,
              fileType: isPdf ? 'pdf' : 'image',
            ));
      } else {
        Get.back();
        Toast.show('Gagal mengunduh file. Status: ${response.statusCode}');
      }
    } catch (e) {
      Get.back();
      Toast.show('Terjadi kesalahan saat membuka file');
      logg('[EXCEPTION] $e');
    }
  }

  Future<void> getSaldo() async {
    try {
      final res = await api.saldo.getDataSaldoPtj();
      logg(res.data);

      if (res.data is Map<String, dynamic>) {
        final saldo = SaldoPtj.fromJson(res.data);
        final saldoValue =
            saldo.saldoAkhirFormat ?? saldo.saldoAkhir?.toString() ?? '0';
        forms.set('saldo', saldoValue);
      } else {
        forms.set('saldo', '0');
        logg(res.data);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
