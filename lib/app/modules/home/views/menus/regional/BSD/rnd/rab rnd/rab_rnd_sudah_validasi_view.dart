import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/rab_it/rab_it.dart';
import 'package:qrm_dev/app/modules/home/controllers/RND/Rab%20RND/rab_rnd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/rab%20rnd/rab_rnd_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class RabRndSudahValidasiView extends GetView<RabRndController> {
  const RabRndSudahValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;
    Get.lazyPut(() => RabRndController());

    return Obx(() {
      bool isLoading = controller.isLoading.value;
      final data = controller.listrab;

      if (isLoading) {
        return const Center(child: CustomLoading());
      }

      if (data.isEmpty) {
        return Empty(
          message: 'Tidak ada data apa pun.',
          onTap: () => controller.getData(),
        );
      }

      final grouped = controller.rabGroupedByBulan;

      return Column(
        children: [
          Padding(
            padding: Ei.sym(v: 10, h: 20),
            child: Row(
              children: [
                Expanded(
                  child: SearchQuery.searchInput(
                    onSubmitted: controller.updateSearchQuery,
                    controller: controller.searchC,
                    hint: 'Search...',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: LzListView(
              padding: Ei.sym(h: 20),
              onRefresh: () => controller.getData(),
              onScroll: (scroll) {
                if (scroll.atBottom(100)) {
                  controller.onPaginate();
                }
              },
              children: [
                const SizedBox(height: 10),

                // ============================
                // FIX: GLOBAL INDEX DI SINI
                // ============================
                ...(() {
                  int globalIndex = 0;

                  return grouped.entries.expand((entry) {
                    final bulan = entry.key;
                    final list = entry.value;

                    return [
                      // HEADER GROUP BULAN
                      Row(
                        children: [
                          Text(
                            bulan,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Divider(
                              thickness: 2,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ).marginOnly(bottom: 10),

                      // ITEM LIST DENGAN ANIMASI
                      ...list.map((item) {
                        final widget = ListItemAnimasi(
                          index: globalIndex,
                          beginOffset: const Offset(-0.3, 0),
                          child: CustomScalaContainer(
                            child: Touch(
                              onTap: () {
                                Get.to(
                                  () => RabRndDetailView(data: item),
                                  arguments: {'id': item.id.toString()},
                                )?.then((value) {
                                  if (value != null) {
                                    controller.updateData(
                                      RabIt.fromJson(value),
                                      item.id!,
                                    );
                                  }
                                });
                              },
                              child: Container(
                                width: itemWidth,
                                padding: const EdgeInsets.all(10),
                                margin: Ei.only(b: 25),
                                decoration: CustomDecoration.validator(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: Column(
                                        crossAxisAlignment: Caa.start,
                                        children: [
                                          Intrinsic(
                                            children: [
                                              Text(
                                                item.kodeRab ?? 'Tidak ada',
                                                style: CustomTextStyle.title(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: statusValidasiColor(
                                                      item.statusBsd),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  statusValidasiText(
                                                      item.statusBsd),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          10.height,
                                          Text(
                                            'Rp ${item.grandtotal}',
                                            style: CustomTextStyle.title(),
                                            textAlign: TextAlign.end,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );

                        globalIndex++; // Increment global index
                        return widget;
                      }),
                    ];
                  }).toList();
                })(),

                // LOADING PAGINATION
                Obx(() =>
                    CustomLoading().lz.hide(!controller.isPaginate.value)),
              ],
            ),
          ),
        ],
      );
    });
  }
}
