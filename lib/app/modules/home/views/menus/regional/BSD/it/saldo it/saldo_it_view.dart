import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/saldo_it.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Saldo%20IT/create_saldo_it_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Saldo%20IT/saldo_it_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/saldo%20it/cetak%20saldo/cetak_saldo_it.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/saldo%20it/create_saldo_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/saldo%20it/debit_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/saldo%20it/kredit_it_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class SaldoItView extends GetView<SaldoItController> {
  const SaldoItView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SaldoItController());
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
              Get.lazyPut(() => CreateSaldoItController());
              Get.to(() => CreateSaldoItView())?.then((data) {
                if (data != null) {
                  controller.insertData(SaldoIt.fromJson(data));
                }
              });
            },
            icon: Icon(Hi.add01),
          ),
          IconButton(
            onPressed: () {
              final cetakController = Get.put(CetakSaldoIt());
              cetakController.showYearDialog();
            },
            icon: Icon(Hi.printer),
          )
        ],
      ).appBar,
      body: Column(
        children: [
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
                return DebitItView();
              } else {
                return KreditItView();
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
                    formatRupiah.format(data?.saldoAkhir ?? 0),
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
