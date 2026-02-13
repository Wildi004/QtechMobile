import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/ptj_logistik/ptj_logistik.dart';

import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/PTJ%20Logistik/ptj_logistik_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/PTJ%20Logistik/ptj_logistik_sudah_validasi_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/ptj%20logistik/create_ptj_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/ptj%20logistik/create_ptj_reg_logistik_view.dart';

class ShowRegionalLogistik {
  static void showRegLogistik(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 240, 239, 239),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pilih PTJ',
                style: TextStyle(fontWeight: Fw.bold),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.close, color: Colors.black),
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              _ptjButton('PTJ Kantor', 'Kantor'),
              const SizedBox(height: 8),
              _ptjButton('PTJ Regional Barat', 'Barat'),
              const SizedBox(height: 8),
              _ptjButton('PTJ Regional Tengah', 'Tengah'),
              const SizedBox(height: 8),
              _ptjButton('PTJ Regional Timur', 'Timur'),
            ],
          ),
        );
      },
    );
  }

  static Widget _ptjButton(String label, String type) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextButton(
        onPressed: () {
          if (type == 'Kantor') {
            Get.to(() => CreatePtjLogistikView(
                  type: 'Kantor',
                ))?.then((data) {
              if (data != null && data is List) {
                final form = Get.find<PtjLogistikController>();
                for (var item in data) {
                  form.insertData(PtjLogistik.fromJson(item));
                }
              }
            });
          } else {
            Get.to(() => CreatePtjRegLogistikView(type: type))?.then((data) {
              if (data != null && data is List) {
                final form = Get.find<PtjLogistikSudahValidasiController>();
                for (var item in data) {
                  form.insertData(PtjLogistik.fromJson(item));
                }
              }
            });
          }
        },
        child: Text(
          label,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
