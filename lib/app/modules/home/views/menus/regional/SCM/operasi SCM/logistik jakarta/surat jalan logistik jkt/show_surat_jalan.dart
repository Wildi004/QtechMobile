import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/pas%20bandara/pas_bandara_hrd_view.dart';

class ShowSuratJalan {
  static void showSj(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pilih Surat Jalan',
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
              _button('Surat Jalan Eksternal'),
              const SizedBox(height: 8),
              _button('Surat Jalan Eksternal NON PPN'),
              const SizedBox(height: 8),
              _button('Surat Jalan Eksternal'),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  static Widget _button(String label) {
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
