import 'package:get/get.dart';

import '../controllers/job_desk_controller.dart';

class JobDeskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobDeskController>(
      () => JobDeskController(),
    );
  }
}
