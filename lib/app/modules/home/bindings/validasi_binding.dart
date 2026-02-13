import 'package:get/get.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/val_pengajuan_dep_controller.dart';

class ValPengajuanDepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ValPengajuanDepController>(() => ValPengajuanDepController());
  }
}
