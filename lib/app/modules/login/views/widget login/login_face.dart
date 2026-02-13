import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class BiometricController extends GetxController {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> authenticate({
    String reason = 'Verifikasi wajah diperlukan',
  }) async {
    try {
      final supported = await _auth.isDeviceSupported();
      if (!supported) {
        Get.snackbar(
            'Biometrik', 'Perangkat tidak mendukung autentikasi biometrik.');
        return false;
      }

      final canCheck = await _auth.canCheckBiometrics;
      final types =
          canCheck ? await _auth.getAvailableBiometrics() : <BiometricType>[];

      // Hanya izinkan Face Unlock
      if (!types.contains(BiometricType.face)) {
        Get.snackbar('Face Unlock', 'Perangkat tidak mendukung face unlock');
        return false;
      }

      // Jalankan autentikasi hanya dengan Face Unlock
      final didAuth = await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      return didAuth;
    } catch (e) {
      Get.snackbar('Biometrik', 'Error: $e');
      return false;
    }
  }
}
