import 'package:fetchly/fetchly.dart';
import 'package:fetchly/utils/log.dart';
import 'package:get/get.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/routes/app_pages.dart';

class RequestHandler {
  static bool _isRefreshing = false;

  static void check(Request request) async {
    int status = request.status;

    if (status == 401 && request.path != 'auth/login') {
      // 🔒 Cegah refresh token ganda
      if (_isRefreshing) {
        logg('[REFRESH] Sudah dalam proses, abaikan request lain');
        return;
      }
      _isRefreshing = true;

      try {
        String? token = storage.read('refresh_token');

        if (token == null) {
          logg('[REFRESH_TOKEN] Tidak ditemukan di storage');
          await _logoutAndRedirect();
          return;
        }

        final apis = Apis();
        final res = await apis.api.auth
            .refreshToken(token)
            .ui
            .loading('Me mperbarui token...');

        if (res.status && res.data != null) {
          final newToken = res.data['token'];
          final refreshToken = res.data['refresh_token'];

          await storage.write('refresh_token', refreshToken);
          await storage.write('token', newToken);
          Fetchly.setToken(newToken);

          logg('[TOKEN REFRESHED] Token baru disimpan');
        } else {
          logg('[REFRESH FAILED] Token refresh gagal atau kadaluarsa');
          await _logoutAndRedirect();
        }
      } catch (e) {
        logg('[REFRESH ERROR] $e');
        await _logoutAndRedirect();
      } finally {
        _isRefreshing = false;
      }
    }

    // Log error lain
    if (![200, 201].contains(status)) {
      logg('[REQUEST_ERROR] ${request.path} => status: $status');
    }
  }

  static Future<void> _logoutAndRedirect() async {
    await storage.remove('token');
    await storage.remove('refresh_token');
    await storage.remove('user');
    Get.offAllNamed(Routes.LOGIN);
  }
}
