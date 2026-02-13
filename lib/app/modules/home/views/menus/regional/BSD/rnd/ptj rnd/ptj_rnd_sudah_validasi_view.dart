import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20it/ptj_it/ptj_it.dart';
import 'package:qrm_dev/app/modules/home/controllers/RND/PTJ%20RND/ptj_rnd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/ptj%20rnd/ptj_rnd_detail_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_format.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';
import 'package:qrm_dev/app/widgets/custom_status_validasi.dart';

class PtjRndSudahValidasiView extends GetView<PtjRndController> {
  const PtjRndSudahValidasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Obx(() {
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
                      item.detailPtjIt != null && item.detailPtjIt!.isNotEmpty;
                  return ListItemAnimasi(
                    index: i,
                    beginOffset: const Offset(-0.3, 0),
                    child: CustomScalaContainer(
                      child: Touch(
                        onTap: () {
                          Get.to(() => PtjRndDetailView(data: item))
                              ?.then((value) {
                            if (value != null) {
                              controller.updateData(PtjIt.fromJson(value),
                                  int.parse(item.noHide.toString()));
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
                                    Intrinsic(
                                      children: [
                                        Text(
                                          item.noPtj ?? 'tidak ada',
                                          style: CustomTextStyle.title(),
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
                                            statusValidasiText(
                                                item.statusGmBsd),
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
                                          hasNominal
                                              ? Rupiah.rupiah(num.tryParse(
                                                  item.total ?? '0'))
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
