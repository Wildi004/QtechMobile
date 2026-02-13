import 'package:get/get.dart';
import 'package:qrm_dev/app/data/apis/api.dart';

class MonitorProyekController extends GetxController with Apis {
  final isFilled = false.obs;
  RxInt tab = 0.obs;

  RxBool isLoading = true.obs;
  var isExpanded = false.obs;
}
