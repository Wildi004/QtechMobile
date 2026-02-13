import 'package:fetchly/utils/log.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintController extends GetxController {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> checkBiometricsAvailable() async {
    final available = await auth.canCheckBiometrics;
    logg('Biometrik tersedia: $available');
    return available;
  }

  Future<bool> authenticate() async {
    try {
      logg('Memulai autentikasi fingerprint...');
      final isAvailable = await checkBiometricsAvailable();
      if (!isAvailable) {
        Get.snackbar('Gagal', 'Fingerprint tidak tersedia di perangkat');
        return false;
      }

      final bool authenticated = await auth.authenticate(
        localizedReason: 'Silakan scan sidik jari untuk login',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      logg('Hasil autentikasi fingerprint: $authenticated');
      return authenticated;
    } catch (e) {
      logg('Terjadi error saat autentikasi: $e');
      Get.snackbar('Error', 'Autentikasi gagal: $e');
      return false;
    }
  }
}
