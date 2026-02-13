import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/kasbon.dart';
import 'package:qrm_dev/app/modules/kasbon/controllers/kasbon_controller.dart';
import 'package:qrm_dev/app/modules/kasbon/views/add_kasbon_view.dart';
import 'package:qrm_dev/app/widgets/custom_main_color.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';

class KasbonBalanceCard extends StatelessWidget {
  final KasbonController controller;
  final String? userName;
  final String? saldo;

  const KasbonBalanceCard({
    super.key,
    required this.controller,
    this.userName,
    this.saldo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: CustomMainColor.main(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: Maa.start,
              crossAxisAlignment: Caa.start,
              children: [
                Text(
                  'Sisa Saldo ${userName ?? '-'} :',
                  style: GoogleFonts.poppins().copyWith(
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                10.height,
                Text(
                  saldo.toString().formatCurrency(),
                  style: GoogleFonts.libreBaskerville().copyWith(
                    color: Colors.white,
                    fontWeight: Fw.bold,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomScalaContainer(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                onTap: () {
                  Get.to(() => AddKasbonView())?.then((data) {
                    if (data != null) {
                      controller.insertData(Kasbon.fromJson(data));
                    }
                  });
                },
                child: Icon(
                  Hi.add01,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Ajukan',
                style: GoogleFonts.poppins().copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

extension CurrencyFormatter on String {
  String formatCurrency() {
    // Format manual biar konsisten, bisa pakai intl kalau mau
    return replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}
