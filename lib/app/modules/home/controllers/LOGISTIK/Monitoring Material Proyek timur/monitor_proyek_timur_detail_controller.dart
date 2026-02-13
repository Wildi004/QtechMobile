import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';

import 'package:qrm_dev/app/data/models/model logistik/monitor_by_kp/monitor_by_kp.dart';

class MonitorProyekTimurDetailController extends GetxController with Apis {
  RxBool isLoading = true.obs;

  // Data hasil fetch
  MonitorByKp? monitor;
  String? kodeProyek;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    kodeProyek = args?['noInt'];

    if (kodeProyek != null) {
      getDetail(kodeProyek!);
    } else {
      isLoading.value = false;
    }
  }

  Future getDetail(String kode) async {
    try {
      isLoading.value = true;

      final res = await api.monitorByKp.getDataByKPTimur(kode);

      logg('RAW DATA: ${res.data}');
      logg('TYPE: ${res.data.runtimeType}');

      if (res.data is! Map) {
        logg('[ERROR] Response bukan Map → ${res.data.runtimeType}');
        return;
      }

      // Convert Map<dynamic, dynamic> → Map<String, dynamic>
      final body = Map<String, dynamic>.from(res.data);

      monitor = MonitorByKp.fromJson(body);
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  // ----- FUNCTION DIALOG -----
}
