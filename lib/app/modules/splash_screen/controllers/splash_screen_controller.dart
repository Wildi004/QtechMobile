import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SplashScreenController extends GetxController {
  late VideoPlayerController videoController;
  RxBool isVideoInitialized = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   videoController = VideoPlayerController.asset('assets/images/animasi2.mp4');

  //   videoController.initialize().then((_) {
  //     videoController.play();
  //     isVideoInitialized.value = true;

  //     videoController.addListener(() {
  //       if (videoController.value.position >= videoController.value.duration) {
  //         // Get.off(() => LoginView());

  //         // cek data token, jika sudah ada berarti sudah pernah login sebelumnya
  //         // maka langsung arahkan ke halaman dashboard

  //         String? token = storage.read('token');

  //         if (token != null) {
  //           Fetchly.setToken(token, prefix: '');
  //           Get.offNamed(Routes.APP);
  //           return;
  //         }

  //         Get.offAndToNamed(Routes.LOGIN);
  //       }
  //     });
  //   });
  // }

  // @override
  // void onClose() {
  //   videoController.dispose();
  //   super.onClose();
  // }
}
