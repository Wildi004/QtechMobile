import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/ptj_dep_bsd/detail.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/ptj_dep_bsd/ptj_dep_bsd.dart';

class PtjDevBsdDetailController extends GetxController with Apis {
  PtjDepBsd? data;
  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'id',
    'no_ptj_reg',
    'tgl_ptj',
    'regional_id',
    'status_dir_keuangan',
    'no_hide',
    'created_name',
    'approved_name',
    'regional_name',
    'detail',
    'total',
  ]);

  final id = Get.parameters['id'];

  PtjDepBsd details = PtjDepBsd();
  RxList<DetailPtjDep> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();
  Future getDetails(PtjDepBsd data) async {
    try {
      String nohide = data.noHide ?? '';
      final res = await api.ptjDepBsd.getDataNoHide(nohide);
      details = PtjDepBsd.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];
      final formatRp =
          NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'no_ptj',
          'Uraian',
          'nama_pengajuan',
          'akun_name',
          'akun_lawan_name',
          'qty',
          'harga_satuan',
          'total_harga',
        ]);

        logg('total_harga: ${e.totalHarga} (${e.totalHarga.runtimeType})');

        // final totalHargaVal = (e.totalHarga ?? '');

        form.fill({
          'no_ptj': (e.subDetail?.isNotEmpty ?? false)
              ? e.subDetail!.first.noPtj ?? '-'
              : '-',
          'nama_pengajuan': e.namaPengajuan ?? '-',
          'Uraian': (e.subDetail?.isNotEmpty ?? false)
              ? e.subDetail!.first.namaBarang ?? '-'
              : '-',
          'akun_name': (e.subDetail?.isNotEmpty ?? false)
              ? e.subDetail!.first.akunName ?? '-'
              : '-',
          'akun_lawan_name': (e.subDetail?.isNotEmpty ?? false)
              ? e.subDetail!.first.akunLawanName ?? '-'
              : '-',
          'qty': (e.subDetail?.isNotEmpty ?? false)
              ? e.subDetail!.first.qty ?? '-'
              : '-',
          'harga_satuan': (e.subDetail?.isNotEmpty ?? false)
              ? formatRp.format(
                  int.tryParse(e.subDetail!.first.hargaSatuan ?? '0') ?? 0,
                )
              : '-',

          // Total harga → format Rp
          'total_harga': (e.subDetail?.isNotEmpty ?? false)
              ? formatRp.format(
                  int.tryParse(e.subDetail!.first.totalHarga ?? '0') ?? 0,
                )
              : '-',
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
