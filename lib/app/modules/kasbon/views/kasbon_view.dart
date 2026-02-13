import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qrm_dev/app/modules/kasbon/controllers/kasbon_controller.dart';
import 'package:qrm_dev/app/modules/kasbon/views/widget%20kasbon/custom_appbar_kasbon.dart';
import 'package:qrm_dev/app/modules/kasbon/views/widget%20kasbon/custom_card_kasbon.dart';
import 'package:qrm_dev/app/modules/kasbon/views/widget%20kasbon/kasbon_list.dart';

class KasbonView extends StatelessWidget {
  final KasbonController controller = Get.put(KasbonController());

  KasbonView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.onPageInit();

    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return Scaffold(
      body: Stack(
        children: [
          const CustomAppbarKasbon(title: 'Kasbon'),
          Obx(() {
            final user = controller.user.value;
            final sisa = controller.sisaKasbon.value;

            return Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: KasbonBalanceCard(
                      controller: controller,
                      userName: user?.name,
                      saldo: sisa?.sisaSaldo ?? '',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (controller.groupedKasbon.isEmpty) {
                        return const Center(
                            child: Text('Tidak ada data kasbon.'));
                      }
                      return KasbonList(
                        currencyFormat: currencyFormat,
                      );
                    }),
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
