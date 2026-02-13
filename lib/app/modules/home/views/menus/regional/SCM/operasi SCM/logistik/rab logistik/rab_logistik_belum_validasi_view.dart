import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/rab_logistik/rab_logistik.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Rab%20logistik/rab_logistik_belum_validasi_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/rab%20logistik/edit_rab_logistik_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/rab%20logistik/rab_logistik_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_format.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class RabLogistikBelumValidasiView
    extends GetView<RabLogistikBelumValidasiController> {
  const RabLogistikBelumValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;
    Get.lazyPut(() => RabLogistikBelumValidasiController());

    return Obx(() {
      bool isLoading = controller.isLoading.value;
      final data = controller.rab;

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
                        onChanged: controller.updateSearchQuery)),
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
                            Get.to(() => RabLogistikDetailView(data: item),
                                arguments: {
                                  'id': item.id.toString(),
                                });
                          },
                          child: Container(
                            width: itemWidth,
                            padding: const EdgeInsets.all(10),
                            margin: Ei.only(b: 25),
                            decoration: CustomDecoration.notValidator(),
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
                                          style:
                                              GoogleFonts.notoSerif().copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      10.width,
                                      Expanded(
                                        child: Builder(
                                          builder: (_) {
                                            final raw = item.grandtotal ?? '0';
                                            final cleaned =
                                                raw.replaceAll(',', '');
                                            final parsed =
                                                num.tryParse(cleaned) ?? 0;

                                            logg(
                                                "Grandtotal item ${item.id}: raw=$raw, cleaned=$cleaned, parsed=$parsed");

                                            return Text(
                                              Rupiah.rupiah(parsed),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
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
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Hi.edit01,
                                          color: Colors.white),
                                      onPressed: () {
                                        Get.to(() =>
                                                EditRabLogistikView(data: item))
                                            ?.then((value) {
                                          if (value != null &&
                                              value is Map<String, dynamic>) {
                                            controller.updateData(
                                                RabLogistik.fromJson(value),
                                                item.id!);
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
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
