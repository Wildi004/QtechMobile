import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';

class ChangeRegionalController extends GetxController with Apis {
  var selected = ''.obs;
  var message = ''.obs;
  var isLoading = false.obs;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    final savedRegion = box.read('selected_region');
    if (savedRegion != null) {
      selected.value = savedRegion;
      message.value = 'Anda sedang berada di regional: $savedRegion';
    }
  }

  Future<void> selectRegion(String region) async {
    try {
      isLoading.value = true;
      selected.value = region;

      final query = {'regional': region};
      final res = await api.cangeRegional.getCange(query);

      if (res.status) {
        message.value = res.message ?? 'Berhasil berpindah ke $region';
        // 💾 Simpan regional yang dipilih
        box.write('selected_region', region);
      } else {
        message.value = res.message ?? 'Gagal berpindah ke $region';
      }
    } catch (e, s) {
      Errors.check(e, s);
      message.value = 'Terjadi kesalahan saat mengubah regional';
    } finally {
      isLoading.value = false;
    }
  }
}
