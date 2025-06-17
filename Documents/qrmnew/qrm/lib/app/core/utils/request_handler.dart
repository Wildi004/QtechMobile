import 'package:fetchly/fetchly.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/services/storage/storage.dart';

import '../../routes/app_pages.dart';

class RequestHandler {
  static void check(Request request) async {
    int status = request.status;

    if (status == 401) {
      Toast.show('Unauthorized, Silakan login kembali.');

      // logout
      await storage.remove('token');
      Get.offAllNamed(Routes.LOGIN);
    }

    if (![200, 201].contains(status)) {
      // final device = await Utils.getDevice();
      // String message =
      //     request.log.toString().replaceAll('-- ', '').replaceAll('== ', '');

      // Bot.sendMessage(
      //     '<b>Error Info</b>\n$message\n<b>Device Info</b>\n${device.value}',
      //     botToken,
      //     chatId);
    }
  }
}
