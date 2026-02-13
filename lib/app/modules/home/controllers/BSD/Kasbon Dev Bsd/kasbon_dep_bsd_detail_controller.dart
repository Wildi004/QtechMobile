import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/kasbon_dep_bsd/detail.dart';
import 'package:qrm_dev/app/data/models/model%20dir%20bsd/kasbon_dep_bsd/kasbon_dep_bsd.dart';

class KasbonDepBsdDetailController extends GetxController with Apis {
  KasbonDepBsd? data;
  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'no_pengajuan_reg',
    'tgl_pengajuan',
    'regional_id',
    'total',
    'status_dir_keuangan',
    'type',
    'updated_by',
    'created_name',
    'updated_name',
    'aprroved_by_name',
    'dep_name',
    'regional_name',
  ]);

  final id = Get.parameters['id'];

  KasbonDepBsd details = KasbonDepBsd();
  RxList<DetailKason> cards = RxList([]);
  RxList<FormManager> formDetails = RxList<FormManager>();
  Future getDetails(KasbonDepBsd data) async {
    try {
      String nohide = data.noHide ?? '';
      final res = await api.kasbonDepBsd.getDataNoHide(nohide);
      details = KasbonDepBsd.fromJson(res.data ?? {});
      cards.value = details.detail ?? [];
      final formatRp =
          NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
      formDetails.value = cards.map((e) {
        final form = LzForm.make([
          'nama_pengajuan',
          'tgl_kasbon',
          'no_pengajuan',
          'keterangan',
          'total_harga',
        ]);

        logg('total_harga: ${e.totalHarga} (${e.totalHarga.runtimeType})');

        final totalHargaVal = (e.totalHarga ?? '');

        form.fill({
          'nama_pengajuan': e.namaPengajuan ?? '-',
          'tgl_kasbon': e.detailKasbon?.tglKasbon ?? '-',
          'no_pengajuan': e.detailKasbon?.noPengajuan ?? '-',
          'keterangan': e.detailKasbon?.keterangan ?? '-',
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
}
