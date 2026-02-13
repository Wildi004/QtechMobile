import 'package:fetchly/utils/log.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionService {
  static Future<bool> needForceUpdate() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    final forceUpdate = remoteConfig.getBool('force_update');
    final minVersion = remoteConfig.getString('min_app_version');

    final info = await PackageInfo.fromPlatform();
    final currentVersion = info.version;
    logg('Current version: $currentVersion');
    logg('Min version: $minVersion');
    logg('Force update: $forceUpdate');

    return forceUpdate && _compareVersion(currentVersion, minVersion) < 0;
  }

  static int _compareVersion(String v1, String v2) {
    final a = v1.split('.').map(int.parse).toList();
    final b = v2.split('.').map(int.parse).toList();

    for (int i = 0; i < 3; i++) {
      final x = i < a.length ? a[i] : 0;
      final y = i < b.length ? b[i] : 0;
      if (x != y) return x.compareTo(y);
    }
    return 0;
  }
}
