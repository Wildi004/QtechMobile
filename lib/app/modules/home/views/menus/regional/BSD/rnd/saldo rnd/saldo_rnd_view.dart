import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20rnd/saldo_rnd.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Saldo%20Dep%20Bsd/saldo_distribusi_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/RND/Saldo%20RND/saldo_rnd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/saldo%20dep%20bsd/saldo_distribusi_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/saldo%20it/cetak%20saldo/cetak_saldo_it.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/saldo%20rnd/debit_rnd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/saldo%20rnd/kredit_rnd_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class SaldoRndView extends GetView<SaldoRndController> {
  const SaldoRndView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SaldoRndController());
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
              Get.lazyPut(() => SaldoDistribusiController());
              Get.to(() => SaldoDistribusiView())?.then((data) {
                if (data != null) {
                  controller.insertData(SaldoRnd.fromJson(data));
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
                return DebitRndView();
              } else {
                return KreditRndView();
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
