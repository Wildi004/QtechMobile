import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/apis/api.dart';
import 'package:qrm/app/data/models/cuti.dart';
import 'package:qrm/app/data/models/user.dart';
import 'package:qrm/app/data/services/image_file_token.dart';
import 'package:qrm/app/data/services/storage/auth.dart';

class SettingsController extends GetxController with Apis {
  RxDouble height = 200.0.obs;
  Rxn<User> user = Rxn<User>();
  Rxn<Cuti> cuti = Rxn<Cuti>();
  RxBool isLoading = true.obs;
  Rx<Uint8List?> imageBytes = Rx<Uint8List?>(null);
  String? imageUrl;
  String? token;

  void adjustHeader(double value) {
    height.value = value;
  }

  Future getUserLogged() async {
    try {
      isLoading.value = true;

      final auth = await Auth.user();
      final res = await api.user.getData(auth.id!);
      user.value = User.fromJson(res.data);

      // Ambil controller ImageFileToken yang sudah di-inject
      final imageController = Get.find<ImageFileToken>();

      // Jika user.image ada dan tidak kosong, langsung load gambarnya
      final imageUrl = user.value?.image ?? '';
      if (imageUrl.isNotEmpty) {
        await imageController.loadImage(imageUrl);
      }
    } catch (e, s) {
      Errors.check(e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Future onPageInit() async {
    try {
      await getUserLogged();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future getDataCuti() async {
    try {
      final auth = await Auth.user();
      final res = await api.cuti.getDataCuti(auth.id!);
      cuti.value = Cuti.fromJson(res.data);
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    Get.put(ImageFileToken());
    getDataCuti();

    getUserLogged();
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
    });
  }
}
