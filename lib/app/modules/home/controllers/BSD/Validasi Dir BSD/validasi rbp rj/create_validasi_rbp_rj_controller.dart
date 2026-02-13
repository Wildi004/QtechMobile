import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/rbp_rb/rbp_rb.dart';

class CreateValidasiRbpRjController extends GetxController with Apis {
  RbpRb? data;
  final isFilled = false.obs;
  RxBool isLoading = true.obs;

  final forms = LzForm.make([
    'status_validasi',
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
    {'id': 1, 'name': 'terima'},
    {'id': 2, 'name': 'tolak'},
  ];

  Future<void> onSubmit(int? id) async {
    try {
      if (data == null) {
        return Toast.show('Data tidak ditemukan.');
      }

      final kesimpulan = forms.extra('status_validasi');

      final payload = {
        'status_validasi': kesimpulan,
      };

      logg('SUBMIT id: $id');
      logg('PAYLOAD: $payload');

      final res = await api.rbpRb
          .validasiRbpRj(payload, id!)
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
