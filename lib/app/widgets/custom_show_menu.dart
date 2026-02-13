import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomShowMenu {
  static void showDialogWithOptions(
    BuildContext context, {
    required String title,
    required List<DialogOption> options,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 219, 219, 219),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.close),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: options
                .map((opt) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: _ptjButton(opt),
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  static Widget _ptjButton(DialogOption option) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        //   border: Border.all( // ⬅️ garis sisi
        //   color: Colors.black,
        //   width: 1,
        // ),
      ),
      child: TextButton(
        onPressed: () {
          Get.back();
          Future.delayed(const Duration(milliseconds: 200), option.onTap);
        },
        child: Text(option.label, style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}

class DialogOption {
  final String label;
  final VoidCallback onTap;
  DialogOption({required this.label, required this.onTap});
}
