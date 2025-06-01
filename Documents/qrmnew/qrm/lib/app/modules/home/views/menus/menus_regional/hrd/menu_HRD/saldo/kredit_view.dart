import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_saldo_controller/saldo_controller.dart';
import 'package:intl/intl.dart';

class KreditView extends GetView<SaldoController> {
  const KreditView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SaldoController());
    final formatCurrency = NumberFormat.currency(
        locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);

    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      bool isLoading = controller.isLoading.value;
      final data = controller.saldo;

      if (isLoading) {
        return Center(child: LzLoader.bar());
      }

      if (data.isEmpty) {
        return Empty(
          message: 'Tidak ada data apa pun.',
          onTap: () => controller.getData(),
        );
      }

      return LzListView(
        padding: Ei.sym(v: 20, h: 20),
        onRefresh: () => controller.getData(),
        onScroll: (scroll) {
          if (scroll.atBottom(100)) {
            controller.onPaginate();
          }
        },
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: controller.updateSearchQuery,
                  decoration: InputDecoration(
                    hintText: "Cari...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 20),

          ...data
              .where((item) => (item.kredit ?? 0) > 0)
              .toList()
              .generate((item, i) {
            return Touch(
              margin: Ei.only(b: 10),
              child: Container(
                width: itemWidth,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 54, 145, 220),
                      const Color.fromARGB(255, 73, 173, 255),
                      const Color.fromARGB(255, 14, 63, 210)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.tglTerima ?? 'tidak ada',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            item.keterangan ?? 'tidak ada',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            formatCurrency.format(item.kredit ?? 0),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [],
                    ),
                  ],
                ),
              ),
            );
          }),

          // animasi loading paginasi
          Obx(() => LzLoader.bar().lz.hide(!controller.isPaginate.value))
        ],
      );
    });
  }
}
