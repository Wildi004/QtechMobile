import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/ptj_logistik/ptj_logistik.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/PTJ%20Logistik/ptj_logistik_belum_validasi_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/ptj%20logistik/ptj_logistik_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_format.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class PtjLogistikBelumValidasiView
    extends GetView<PtjLogistikBelumValidasiController> {
  const PtjLogistikBelumValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
      Get.lazyPut(() => PtjLogistikBelumValidasiController());
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
                  return CustomScalaContainer(
                    child: Touch(
                      onTap: () {
                        Get.to(() => PtjLogistikDetailView(data: item))
                            ?.then((value) {
                          if (value != null) {
                            controller.updateData(PtjLogistik.fromJson(value),
                                int.parse(item.noHide.toString()));
                          }
                        });
                      },
                      margin: Ei.only(b: 10),
                      child: Container(
                        width: itemWidth,
                        padding: const EdgeInsets.all(10),
                        decoration: CustomDecoration.notValidator(),
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
                                        item.total != null &&
                                                item.total!.isNotEmpty
                                            ? Rupiah.rupiah(
                                                num.tryParse(item.total ?? '0'))
                                            : 'tidak ada data',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
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
