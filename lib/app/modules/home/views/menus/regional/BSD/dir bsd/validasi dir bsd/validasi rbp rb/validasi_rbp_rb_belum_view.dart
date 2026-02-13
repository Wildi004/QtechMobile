import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20rbp%20rb/validasi_rbp_rb_belum_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20rbp%20rb/info_pekerjaan_val_rbp_rb_view.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class ValidasiRbpRbBelumView extends GetView<ValidasiRbpRbBelumController> {
  const ValidasiRbpRbBelumView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ValidasiRbpRbBelumController());

    return Obx(() {
      bool isLoading = controller.isLoading.value;
      final data = controller.listData;

      if (isLoading) {
        return Center(child: CustomLoading());
      }

      if (data.isEmpty) {
        return Empty(
          message: 'Tidak ada Surat Keluar.',
          onTap: () => controller.getData(),
        );
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                ...data.generate((item, i) {
                  final isExpanded = controller.expandedItems.contains(i);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomScalaContainer(
                        child: Touch(
                          margin: Ei.only(b: 10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: CustomDecoration.validator(),
                            child: Column(
                              crossAxisAlignment: Caa.start,
                              children: [
                                Row(
                                  mainAxisAlignment: Maa.spaceBetween,
                                  children: [
                                    Text(
                                      item.kodeRbp ?? '-',
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyle.title(),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        isExpanded
                                            ? Hi.arrowUp01
                                            : Hi.arrowDown01,
                                      ),
                                      onPressed: () =>
                                          controller.toggleExpand(i),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: Maa.spaceBetween,
                                  children: [
                                    Text(
                                      item.kodeProyek ?? '-',
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyle.title(),
                                    ),
                                    Text(
                                      item.proyek?.tglKontrak ?? '-',
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyle.title(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return SizeTransition(
                            sizeFactor: animation,
                            axisAlignment: -1.0,
                            child: child,
                          );
                        },
                        child: isExpanded
                            ? InfoPekerjaanValRbpRbView(
                                key: ValueKey(item.id),
                                proyek: item.proyek,
                                data: item,
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  );
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
