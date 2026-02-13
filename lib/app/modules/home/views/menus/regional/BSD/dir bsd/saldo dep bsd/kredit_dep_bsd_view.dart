import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:intl/intl.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Saldo%20Dep%20Bsd/saldo_dep_bsd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/saldo%20dep%20bsd/detail_saldo_dep_bsd_view.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class KreditDepBsdView extends GetView<SaldoDepBsdController> {
  const KreditDepBsdView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SaldoDepBsdController());
    final formatCurrency = NumberFormat.currency(
        locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0);

    return Obx(() {
      bool isLoading = controller.isLoading.value;
      final data = controller.listSaldo;

      if (isLoading) {
        return Center(child: CustomLoading());
      }

      if (data.isEmpty) {
        return Empty(
          message: 'Tidak ada data apa pun.',
          onTap: () => controller.getData(),
        );
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: SearchQuery.searchInput(
                      onSubmitted: controller.updateSearchQuery,
                      controller: controller.searchC,
                      hint: 'Search...'),
                ),
              ],
            ),
          ),
          Expanded(
            child: LzListView(
              padding: Ei.sym(v: 0, h: 20),
              onRefresh: () => controller.getData(),
              onScroll: (scroll) {
                if (scroll.atBottom(100)) {
                  controller.onPaginate();
                }
              },
              children: [
                ...data
                    .where((item) => (item.kredit ?? 0) > 0)
                    .toList()
                    .generate((item, i) {
                  return CustomScalaContainer(
                    child: Touch(
                      onTap: () {
                        Get.to(() => DetailSaldoDepBsdView(data: item))
                            ?.then((value) {});
                      },
                      margin: Ei.only(b: 10),
                      child:
                          LzCard(padding: const EdgeInsets.all(10), children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.tglTerima ?? 'tidak ada',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    item.keterangan ?? 'tidak ada',
                                    style: const TextStyle(),
                                    maxLines: 99,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    formatCurrency.format(item.kredit ?? 0),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  );
                }),

                // animasi loading paginasi
                Obx(() => CustomLoading().lz.hide(!controller.isPaginate.value))
              ],
            ),
          ),
        ],
      );
    });
  }
}
