import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/pas%20bandara/pas_bandara_hrd_view.dart';

class ShowInvoiveDelPoView {
  static void showInv(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: Maa.spaceBetween,
            children: [
              const Text(
                'Pilih invoice',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              _ptjButton('Invoive Material Po Non Ppn'),
              const SizedBox(height: 8),
              _ptjButton('Invoive Material Po Ppn'),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  static Widget _ptjButton(String label) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextButton(
        onPressed: () {
          Get.back();
          Future.delayed(const Duration(milliseconds: 200), () {
            if (label.contains('Bali')) {
              Get.to(() => const PasBandaraHrdView());
            } else if (label.contains('Jakarta')) {
              Get.snackbar('Maaf', 'Belum Tersedia');
            }
          });
        },
        child: Text(
          label,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
