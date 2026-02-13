import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/pengajuan_logistik/pengajuan_logistik.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Pengajuan%20Logistik/pengajuan_logistik_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/pengajuan%20logistik/pengajuan_logistik_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_format.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class PengajuanLogistikSudahValidasiView
    extends GetView<PengajuanLogistikController> {
  const PengajuanLogistikSudahValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      Get.lazyPut(() => PengajuanLogistikController());
      bool isLoading = controller.isLoading.value;
      final data = controller.listPengajuan;

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
                        Get.to(() => PengajuanLogistikDetailView(
                              data: item,
                              showPrintButton: true,
                            ))?.then((value) {
                          if (value != null) {
                            controller.updateData(
                                PengajuanLogistik.fromJson(value),
                                item.noHide!);
                          }
                        });
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
                                    item.createdName ?? 'tidak ada',
                                    style: CustomTextStyle.title(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Intrinsic(
                                    children: [
                                      Text(
                                        item.noPengajuan ?? 'tidak ada',
                                        style: CustomTextStyle.subtitle(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: statusValidasiColor(
                                              item.statusGmBsd),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          statusValidasiText(item.statusGmBsd),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        item.detail != null &&
                                                item.detail!.isNotEmpty
                                            ? Rupiah.rupiah(
                                                item.detail!.first.totalHarga)
                                            : 'tidak ada data',
                                        style: CustomTextStyle.title(),
                                      ),
                                      Text(
                                        ' || ${item.tglPengajuan ?? 'tidak ada'}',
                                        style: CustomTextStyle.subtitle(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
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
