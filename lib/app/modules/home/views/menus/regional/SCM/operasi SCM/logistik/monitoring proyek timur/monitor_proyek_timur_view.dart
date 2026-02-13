import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Monitoring%20Material%20Proyek%20timur/monitor_proyek_timur_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Monitoring%20Material%20Proyek%20timur/monitor_proyek_timur_detail_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/monitoring%20proyek%20timur/monitor_proyek_timur_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class MonitorProyekTimurView extends GetView<MonitorProyekTimurController> {
  const MonitorProyekTimurView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      Get.lazyPut(() => MonitorProyekTimurController());
      bool isLoading = controller.isLoading.value; //
      final data = controller.listData;

      if (isLoading) {
        return Center(child: CustomLoading());
      }

      if (data.isEmpty) {
        return Empty(
          message: 'Data sudah validasi semua.',
          onTap: () => controller.getData(),
        );
      }

      return Column(
        children: [
          Padding(
            padding: Ei.sym(h: 20),
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
          10.height,
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
                ...data.generate((item, i) {
                  return CustomScalaContainer(
                    child: Touch(
                        onTap: () {
                          Get.lazyPut(
                              () => MonitorProyekTimurDetailController());

                          Get.to(
                            () => MonitorProyekTimurDetailView(),
                            arguments: {
                              "noInt": item.kodeProyekString,
                              "data": item,
                            },
                          );
                        },
                        margin: Ei.only(b: 10),
                        child: Container(
                          width: itemWidth,
                          padding: const EdgeInsets.all(10),
                          decoration: CustomDecoration.validator(),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.kodeProyek ?? 'tidak ada',
                                      style: GoogleFonts.notoSerif().copyWith(
                                        color: Colors.white,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      item.judulKontrak ?? 'tidak ada',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Intrinsic(children: [
                                      Text(
                                        'Nilai Kontrak :',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Status RAP :',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ]),
                                    Intrinsic(children: [
                                      Text(
                                        formatRupiah(item.nilaiKontrak),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color:
                                              statusBgColor(item.statusProyek),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          statusText(item.statusProyek),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ])
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
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

String formatRupiah(int? value) {
  if (value == null) return '-';
  return NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  ).format(value);
}

String statusText(int? status) {
  switch (status) {
    case 0:
      return 'Belum mulai';
    case 1:
      return 'On Going';
    case 2:
      return 'Selesai';
    default:
      return '-';
  }
}

Color statusBgColor(int? status) {
  switch (status) {
    case 0:
      return Colors.blue;
    case 1:
      return Colors.orange;
    case 2:
      return Colors.green;
    default:
      return Colors.grey;
  }
}
