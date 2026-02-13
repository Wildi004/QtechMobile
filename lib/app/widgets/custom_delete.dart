import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';

class CustomDelete {
  static void customDelete({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    Get.defaultDialog(
      title: 'Konfirmasi',
      titleStyle: TextStyle(fontWeight: Fw.bold),
      middleText: 'Apakah Anda yakin ingin menghapus data ini?',
      middleTextStyle: TextStyle(
        fontSize: MediaQuery.of(context).size.height * 0.018,
      ),
      textConfirm: 'Ya',
      buttonColor: const Color.fromARGB(255, 163, 29, 29),
      textCancel: 'Batal',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        onConfirm();
      },
    );
  }

  static void show({
    required BuildContext context,
    String title = DialogMessages.confirmTitle,
    String message = DialogMessages.confirmMessage,
    required VoidCallback onConfirm,
  }) {
    context.confirm(
      title: title,
      message: message,
      onConfirm: onConfirm,
    );
  }
}

class DialogMessages {
  static const String confirmTitle = 'Konfirmasi';
  static const String confirmMessage =
      'Apakah Anda Yakin Ingin Mengirim Data Laporan Ini?';
}
