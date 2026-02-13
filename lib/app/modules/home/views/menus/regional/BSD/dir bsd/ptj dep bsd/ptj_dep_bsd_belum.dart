import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Ptj%20Dev%20Bsd/ptj_dev_bsd_belum_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/ptj%20dep%20bsd/ptj_dep_bsd_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_format.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class PtjDepBsdBelum extends GetView<PtjDevBsdBelumController> {
  const PtjDepBsdBelum({super.key});
  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;
    return Obx(() {
      Get.lazyPut(() => PtjDevBsdBelumController());
      bool isLoading = controller.isLoading.value;
      final data = controller.listPengajuan;
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
                  return ListItemAnimasi(
                    index: i,
                    beginOffset: const Offset(-0.3, 0),
                    child: CustomScalaContainer(
                      child: Touch(
                          onTap: () {
                            Get.to(() => PtjDepBsdDetailView(
                                  data: item,
                                  showPrintButton: true,
                                ));
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            item.noPtjReg ?? 'tidak ada',
                                            style: CustomTextStyle.subtitle(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: statusValidasiColor(
                                                  item.statusDirKeuangan),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              statusValidasiText(
                                                  item.statusDirKeuangan),
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
                                            item.total != null
                                                ? Rupiah.rupiah(item.total)
                                                : 'tidak ada data',
                                            style: CustomTextStyle.title(),
                                          ),
                                          Text(
                                            ' || ${item.tglPtj ?? 'tidak ada'}',
                                            style: CustomTextStyle.subtitle(),
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
                          )),
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
