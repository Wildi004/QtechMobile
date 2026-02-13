import 'package:fetchly/fetchly.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/config.dart';
import 'package:qrm_dev/app/core/utils/request_handler.dart';
import 'package:qrm_dev/app/data/services/Service%20Update/forve_update_page_view.dart';
import 'package:qrm_dev/app/data/services/Service%20Update/version_service.dart';
import 'package:qrm_dev/app/data/services/storage/storage.dart';
import 'package:qrm_dev/app/modules/home/controllers/assistive_controller.dart';
import 'package:qrm_dev/app/modules/home/views/widget%20home%20view/widget%20home/assistive_touch_widget.dart';
import 'package:qrm_dev/app/modules/settings/views/menus%20setting/pengaturan/controllers/navitheme.dart';
import 'package:qrm_dev/app/modules/settings/views/menus%20setting/pengaturan/controllers/pengaturan_controller.dart';
import 'package:qrm_dev/app/routes/app_pages.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   LazyUi.init(icon: IconType.huge);
//   await GetStorage.init();
//   storage = GetStorage();
//   Fetchly.init(
//     baseUrl: 'https://laravel.apihbr.link/api/',
//     onRequest: RequestHandler.check,
//   );
//   String? token = storage.read('token');
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//   runApp(MyApp(token: token));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await setupRemoteConfig();

  // await initFcmToken();
  final needUpdate = await AppVersionService.needForceUpdate();
  if (needUpdate) {
    runApp(const MaterialApp(home: ForceUpdatePage()));
    return;
  }

  await initializeDateFormatting('id_ID', null);
  LazyUi.init(icon: IconType.huge);
  final isMaintenance =
      FirebaseRemoteConfig.instance.getBool('maintenance_mode');
  logg('Maintenance mode: $isMaintenance');

  Get.put(PengaturanController());
  Get.put(AssistiveTouchController(), permanent: true);

  await GetStorage.init();
  storage = GetStorage();

  String? token = storage.read('token');
  logg('Token di storage: $token');

  Fetchly.init(
    baseUrl: AppConfig.baseUrl,
    onRequest: RequestHandler.check,
  );

  if (token != null) {
    Fetchly.setToken(token);
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, this.token});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Q-tech Mobile",
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color.fromARGB(255, 243, 243, 243),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 0, 0, 0),
          secondary: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      darkTheme: darkThemeCustom,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: token != null ? Routes.APP : Routes.LOGIN,
      getPages: AppPages.routes,
      routingCallback: (routing) {
        final route = routing?.current ?? '';
        Get.find<AssistiveTouchController>().updateByRoute(route);
      },
      builder: (context, child) {
        final c = Get.find<AssistiveTouchController>();
        return Stack(
          children: [
            FontScaling(child: Toast.builder(context, child)),
            Obx(() => c.show.value ? AssistiveTouchWidget() : const SizedBox()),
          ],
        );
      },
    );
  }
}

Future<void> setupRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 0),
    ),
  );
  await remoteConfig.setDefaults({
    'maintenance_mode': false,
    'force_update': false,
    'min_app_version': '1.0.0',
  });
  await remoteConfig.fetchAndActivate();
}

// Future<void> initFcmToken() async {
//   final messaging = FirebaseMessaging.instance;

//   await messaging.requestPermission();

//   logg('FCM TOKEN: $token');

//   FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
//     logg('FCM TOKEN REFRESH: $newToken');
//   });
// }
