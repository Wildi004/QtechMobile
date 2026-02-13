import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/capaian_kerja1/capaian_kerja1.dart';

class DetailCapaian1Controller extends GetxController with Apis {
  final Capaian1 data;
  DetailCapaian1Controller(this.data);
  var tabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    logg('Detail data: ${data.departemen} total: ${data.total}');
  }
}
