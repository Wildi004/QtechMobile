import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/core/utils/request_handler.dart';
import 'package:qrm/app/data/services/storage/storage.dart';
import 'package:qrm/app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LazyUi.init(icon: IconType.huge);

  await GetStorage.init();
  storage = GetStorage();

  Fetchly.init(
      baseUrl: 'https://laravel.apihbr.link/api/',
      onRequest: RequestHandler.check);
  String? token = storage.read('token');

  runApp(
    GetMaterialApp(
      title: "QRM Mobile",
      theme: LzTheme.light,
      debugShowCheckedModeBanner: false,
      initialRoute: token != null ? Routes.APP : Routes.LOGIN,
      getPages: AppPages.routes,
      builder: (context, child) {
        return FontScaling(
          child: Toast.builder(context, child),
        );
      },
    ),
  );
}
