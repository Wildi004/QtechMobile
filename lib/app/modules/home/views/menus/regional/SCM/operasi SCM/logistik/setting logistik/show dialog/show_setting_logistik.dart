import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/setting%20logistik/kategori%20aset/kategori_aset_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/setting%20logistik/setting_logistik_view.dart';

class ShowSettingLogistik {
  static void showMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: Maa.spaceBetween,
            children: [
              const Text(
                'Setting Logistik',
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
              _button('Setting Satuan'),
              const SizedBox(height: 8),
              _button('Setting kategori aset'),
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
            if (label == 'Setting Satuan') {
              Get.to(() => const SettingLogistikView());
            } else if (label == 'Setting kategori aset') {
              Get.to(() => const KategoriAsetView());
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
