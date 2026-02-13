import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/ptj_hrd/ptj_hrd.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_ptj_controller/ptj_hrd_belum_validasi_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/ptj/detail_ptj_hrd_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_format.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class PtjHrdBelumValidasiView extends GetView<PtjHrdBelumValidasiController> {
  const PtjHrdBelumValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      Get.lazyPut(() => PtjHrdBelumValidasiController());
      bool isLoading = controller.isLoading.value;
      final data = controller.listPtj;

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
            padding: Ei.sym(h: 20, v: 10),
            child: Row(
              children: [
                Expanded(
                  child: SearchQuery.searchInput(
                      onSubmitted: controller.updateSearchQuery,
                      controller: controller.searchC,
                      hint: 'Search...'),
                ),
                SizedBox(width: 10),
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
                ...data.generate((item, i) {
                  final bool hasNominal =
                      item.detailPtj != null && item.detailPtj!.isNotEmpty;

                  return CustomScalaContainer(
                    child: Touch(
                      onTap: () {
                        Get.to(() => DetailPtjHrdView(data: item))
                            ?.then((value) {
                          if (value != null) {
                            controller.updateData(PtjHrd.fromJson(value),
                                int.parse(item.noHide.toString()));
                          }
                        });
                      },
                      margin: Ei.only(b: 10),
                      child: Container(
                        width: itemWidth,
                        padding: const EdgeInsets.all(10),
                        decoration: hasNominal
                            ? CustomDecoration.orange()
                            : CustomDecoration.notValidator(),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.noPtj ?? 'tidak ada',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          hasNominal
                                              ? Rupiah.rupiah(num.tryParse(
                                                  item.total ?? '0'))
                                              : 'tidak ada data',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: hasNominal
                                                ? Colors.white
                                                : const Color.fromARGB(
                                                    137, 255, 255, 255),
                                            fontSize: 13,
                                          )),
                                      Text(
                                        ' || ${item.tglPtj ?? 'tidak ada'}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                Obx(() => CustomLoading().lz.hide(!controller.isPaginate.value))
              ],
            ),
          ),
        ],
      );
    });
  }
}
