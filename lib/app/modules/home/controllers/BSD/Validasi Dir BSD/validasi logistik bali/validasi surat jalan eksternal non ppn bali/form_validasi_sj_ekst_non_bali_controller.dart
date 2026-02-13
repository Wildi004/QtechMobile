import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/surat_jalan_exst_non/surat_jalan_exst_non.dart';

class FormValidasiSjEkstNonBaliController extends GetxController with Apis {
  SuratJalanExstNon? data;
  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'kesimpulan_status_validasi',
  ]);

  final id = Get.parameters['id'];

  RxList<FormManager> formDetails = RxList<FormManager>();

  @override
  void onInit() {
    super.onInit();

    if (data != null) {
      forms.fill(data!.toJson());
    }
  }

  Future<List<Map>> getFinal() async {
    return gfinal;
  }

  final gfinal = [
    {'id': 0, 'name': 'Tolak'},
    {'id': 1, 'name': 'Terima'},
  ];

  Future<void> onSubmit(String? noHide) async {
    try {
      if (data == null) {
        return Toast.show('Data tidak ditemukan.');
      }

      final kesimpulan = forms.extra('kesimpulan_status_validasi');

      final payload = {
        'kesimpulan_status_validasi': kesimpulan,
      };

      logg('SUBMIT NOHIDE: $noHide');
      logg('PAYLOAD: $payload');

      final res = await api.suratJalanExstNon
          .validasiSuratJalanExstNon(payload, noHide!)
          .ui
          .loading('Mengirim validasi...');

      if (res.status) {
        Toast.show('Validasi berhasil dikirim');
        Get.back(result: true);
      } else {
        Toast.error(res.message ?? 'Gagal mengirim validasi');
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}
