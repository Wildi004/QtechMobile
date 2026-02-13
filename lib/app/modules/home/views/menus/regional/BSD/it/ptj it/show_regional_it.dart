import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/ptj_hrd/ptj_hrd.dart';
import 'package:qrm_dev/app/data/models/models%20it/ptj_it/ptj_it.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_ptj_controller/ptj_sudah_validasi_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/PTJ%20IT/ptj_it_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/ptj%20it/create_ptj_reg_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/ptj%20it/create_ptj_view.dart';

class ShowRegionalIt {
  static void showRegIt(BuildContext context) {
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
            Get.to(() => CreatePtjView(
                  type: 'Kantor',
                ))?.then((data) {
              if (data != null && data is List) {
                final form = Get.find<PtjItController>();
                for (var item in data) {
                  form.insertData(PtjIt.fromJson(item));
                }
              }
            });
          } else {
            Get.to(() => CreatePtjRegItView(type: type))?.then((data) {
              if (data != null && data is List) {
                final form = Get.find<PtjSudahValidasiController>();
                for (var item in data) {
                  form.insertData(PtjHrd.fromJson(item));
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
