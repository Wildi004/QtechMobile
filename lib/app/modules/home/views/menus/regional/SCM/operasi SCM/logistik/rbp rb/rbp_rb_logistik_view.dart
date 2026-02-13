import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Rbp%20Rb%20Logistik/rbp_rb_logistik_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/logistik/rbp%20rb/widget%20rbp%20rb%20logistik/info_pekerjaan_rbp_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class RbpRbLogistikView extends GetView<RbpRbLogistikController> {
  const RbpRbLogistikView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RbpRbLogistikController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'RBP RB',
      ).appBar,
      resizeToAvoidBottomInset: false,
      body: Obx(() {
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
                              width: itemWidth,
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
                                        style: GoogleFonts.poppins().copyWith(
                                          color: Colors.white,
                                          fontWeight: Fw.bold,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          isExpanded
                                              ? Hi.arrowUp01
                                              : Hi.arrowDown01,
                                          color: Colors.white,
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
                                        style: GoogleFonts.poppins().copyWith(
                                          color: Colors.white,
                                          fontWeight: Fw.bold,
                                        ),
                                      ),
                                      Text(
                                        item.proyek?.tglKontrak ?? '-',
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins().copyWith(
                                          color: Colors.white,
                                          fontWeight: Fw.bold,
                                        ),
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
                              ? ProyekDetailCard(
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
      }),
    );
  }
}
