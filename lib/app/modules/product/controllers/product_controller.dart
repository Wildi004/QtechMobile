import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxInt step = 1.obs;
  RxString result = ''.obs;

  Future<void> startFormFlow(BuildContext context) async {
    String? input;

    for (int i = 1; i <= 5; i++) {
      input =
          await showFormDialog(context, 'Form ke-$i', 'Masukkan "lanjut$i"');

      if (input != 'lanjut$i') {
        Get.snackbar('Salah', 'Input salah. Form ke-$i dibatalkan.');
        return;
      }
      result.value += 'Step $i OK\n';
    }

    Get.snackbar('Selesai', 'Semua form selesai!');
  }

  Future<String?> showFormDialog(
      BuildContext context, String title, String hint) async {
    TextEditingController controller = TextEditingController();

    return await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: hint),
        ),
        actions: [
          TextButton(
            child: const Text('Kirim'),
            onPressed: () {
              Navigator.of(context).pop(controller.text);
            },
          )
        ],
      ),
    );
  }
}
