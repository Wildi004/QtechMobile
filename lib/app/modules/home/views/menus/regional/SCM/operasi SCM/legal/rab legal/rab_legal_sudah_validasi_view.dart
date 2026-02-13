import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20legal/rab_legal/rab_legal.dart';
import 'package:qrm_dev/app/modules/home/controllers/LEGAL/Rab%20Legal/rab_legal_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/rab%20legal/rab_legal_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class RabLegalSudahValidasiView extends GetView<RabLegalController> {
  const RabLegalSudahValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;
    Get.lazyPut(() => RabLegalController());

    return Obx(() {
      bool isLoading = controller.isLoading.value;
      final data = controller.listrab;

      if (isLoading) {
        return Center(child: CustomLoading());
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
                      hint: 'Search...'),
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
                SizedBox(height: 10),
                ...grouped.entries.expand((entry) {
                  final bulan = entry.key;
                  final list = entry.value;

                  return [
                    Row(
                      children: [
                        Text(
                          bulan,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ).marginOnly(bottom: 10),
                    ...list.generate((item, i) {
                      return CustomScalaContainer(
                        child: Touch(
                          onTap: () {
                            Get.to(() => RabLegalDetailView(data: item),
                                arguments: {
                                  'id': item.id.toString(),
                                })?.then((value) {
                              if (value != null) {
                                controller.updateData(
                                    RabLegal.fromJson(value), item.id!);
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: Caa.start,
                                    children: [
                                      Text(
                                        item.kodeRab ?? 'tidak ada',
                                        style: GoogleFonts.poppins().copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      10.height,
                                      Text(
                                        'Rp ${item.grandtotal}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.end,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ];
                }),
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
