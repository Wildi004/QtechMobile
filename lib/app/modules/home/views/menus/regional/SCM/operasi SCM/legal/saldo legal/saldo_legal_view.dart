import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/saldo.dart';
import 'package:qrm_dev/app/modules/home/controllers/LEGAL/Saldo%20Legal/create_saldo_legal_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/LEGAL/Saldo%20Legal/saldo_legal_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/saldo%20legal/cetak%20saldo%20legal/cetak_saldo_legal.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/saldo%20legal/create_saldo_legal_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/saldo%20legal/debit_legal_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/saldo%20legal/kredit_legal_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class SaldoLegalView extends GetView<SaldoLegalController> {
  const SaldoLegalView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SaldoLegalController());
    final formatRupiah = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Saldo',
        actions: [
          IconButton(
            onPressed: () {
              Get.lazyPut(() => CreateSaldoLegalController());
              Get.to(() => CreateSaldoLegalView())?.then((data) {
                if (data != null) {
                  controller.insertData(Saldo.fromJson(data));
                }
              });
            },
            icon: Icon(Hi.add01),
          ),
          IconButton(
            onPressed: () {
              final cetakController = Get.put(CetakSaldoLegal());
              cetakController.showYearDialog();
            },
            icon: Icon(Hi.printer),
          )
        ],
      ).appBar,
      body: Column(
        children: [
          // Tab bar
          Padding(
            padding: const EdgeInsets.all(10),
            child: Obx(() {
              int tab = controller.tab.value;
              double width = (Get.width - 56) / 2;

              return Stack(
                alignment: Ad.center,
                children: [
                  Intrinsic(
                    children: ['Debit', 'Kredit'].generate((label, i) {
                      return InkTouch(
                        onTap: () {
                          controller.tab.value = i;
                        },
                        padding: Ei.sym(v: 5, h: 5),
                        color: Colors.white,
                        child: Text(
                          label,
                          textAlign: Ta.center,
                          style: Gfont.fbold(tab == i),
                        ),
                      );
                    }),
                  ),
                  AnimatedPositioned(
                    duration: 250.ms,
                    left: tab == 0 ? (width * tab) + 4 : (width * tab) + 11,
                    child: Container(
                      width: width,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.orange.applyOpacity(.3),
                        borderRadius: Br.radius(5),
                      ),
                    ),
                  ),
                ],
              ).lz.clip(all: 7).lz.border(Br.all(), radius: Br.radius(7));
            }),
          ),

          10.height,

          Expanded(
            child: Obx(() {
              if (controller.tab.value == 0) {
                return DebitLegalView();
              } else {
                return KreditLegalView();
              }
            }),
          ),
          Obx(() {
            final data = controller.saldoPtj.value;
            logg(data);
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Br.all(),
              ),
              child: Row(
                children: [
                  Text(
                    'Total Saldo: ',
                    style: TextStyle(fontWeight: Fw.bold),
                  ),
                  Text(
                    formatRupiah
                        .format(data?.saldoAkhir ?? 0), // format jadi Rp
                    textAlign: Ta.center,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
