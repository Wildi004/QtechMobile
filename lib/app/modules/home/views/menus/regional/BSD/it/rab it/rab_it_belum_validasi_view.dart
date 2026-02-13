import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/rab_it/rab_it.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Rab%20IT/rab_it_belum_validasi_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/rab%20it/edit_rab_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/rab%20it/rab_it_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_format.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class RabItBelumValidasiView extends GetView<RabItBelumValidasiController> {
  const RabItBelumValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;
    Get.lazyPut(() => RabItBelumValidasiController());

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
                      return ListItemAnimasi(
                        index: i,
                        beginOffset: const Offset(-0.3, 0),
                        child: CustomScalaContainer(
                          child: Touch(
                            onTap: () {
                              Get.to(() => RabItDetailView(data: item),
                                  arguments: {
                                    'id': item.id.toString(),
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.kodeRab ?? 'tidak ada',
                                            style: CustomTextStyle.title(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        10.width,
                                        Expanded(
                                          child: Builder(
                                            builder: (_) {
                                              final raw =
                                                  item.grandtotal ?? '0';
                                              final cleaned =
                                                  raw.replaceAll(',', '');
                                              final parsed =
                                                  num.tryParse(cleaned) ?? 0;

                                              logg(
                                                  "Grandtotal item ${item.id}: raw=$raw, cleaned=$cleaned, parsed=$parsed");

                                              return Text(
                                                Rupiah.rupiah(parsed),
                                                style: CustomTextStyle.title(),
                                                textAlign: TextAlign.end,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Hi.edit01,
                                        ),
                                        onPressed: () {
                                          Get.to(() =>
                                                  EditRabItView(data: item))
                                              ?.then((value) {
                                            if (value != null &&
                                                value is Map<String, dynamic>) {
                                              controller.updateData(
                                                  RabIt.fromJson(value),
                                                  item.id!);
                                            }
                                          });
                                        },
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: statusValidasiColor(
                                              item.statusBsd),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          statusValidasiText(item.statusBsd),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
