import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/pas%20bandara%20controller/pas_bandara_hrd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/pas%20bandara/detail_pas_bandara_hrd_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class PasBandaraHrdView extends GetView<PasBandaraHrdController> {
  const PasBandaraHrdView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => PasBandaraHrdController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Pas Bandara',
      ).appBar,
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        bool isLoading = controller.isLoading.value;
        final data = controller.listPasBan;

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
              padding: Ei.sym(v: 20, h: 20),
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
                          context.openBottomSheet(
                              DetailPasBandaraHrdView(data: item));
                        },
                        margin: Ei.only(b: 10),
                        child: Container(
                          width: itemWidth,
                          padding: const EdgeInsets.all(10),
                          decoration: CustomDecoration.validator(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                item.noPengajuan ?? '-',
                                style: GoogleFonts.poppins().copyWith(
                                    color: Colors.white, fontWeight: Fw.bold),
                              ),
                              Text(
                                item.proyekItemName ?? '-',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: Maa.spaceBetween,
                                children: [
                                  Text(
                                    item.jenisPas ?? '-',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    item.tglPengajuan ?? '-',
                                    style: GoogleFonts.robotoCondensed()
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: Fw.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
