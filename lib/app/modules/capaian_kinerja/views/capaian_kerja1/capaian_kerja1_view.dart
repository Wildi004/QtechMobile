import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/modules/capaian_kinerja/controllers/capaian%20kinerja1/capaian_kerja1_controller.dart';
import 'package:qrm_dev/app/modules/capaian_kinerja/views/capaian_kerja1/detail_capaian1_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class CapaianKerja1View extends GetView<CapaianKerja1Controller> {
  const CapaianKerja1View({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CapaianKerja1Controller());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar(title: 'Capaian Kinerja').appBar,
      body: Padding(
        padding: Ei.all(MediaQuery.of(context).size.height * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search bar
            Row(
              children: [
                Expanded(
                  child: SearchQuery.searchInput(
                    onChanged: controller.updateSearchQuery,
                    hint: 'Cari departemen...',
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            Expanded(
              child: Obx(() {
                final isLoading = controller.isLoading.value;
                final capaian = controller.capaian;

                if (isLoading) {
                  return const Center(child: CustomLoading());
                }

                if (capaian.isEmpty) {
                  return Empty(
                    message: 'Tidak ada data apa pun.',
                    onTap: () => controller.getData(),
                  );
                }

                return LzListView(
                  padding: Ei.sym(v: 20),
                  onRefresh: () => controller.getData(),
                  onScroll: (scroll) {
                    if (scroll.atBottom(100)) controller.onPaginate();
                  },
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: capaian.generate((data, i) {
                        return ListItemAnimasi(
                          index: i,
                          beginOffset: const Offset(-0.3, 0),
                          child: Material(
                            borderRadius: Br.radius(15),
                            child: Touch(
                              onTap: () {
                                context.openBottomSheet(
                                  DetailCapaian1View(data: data),
                                );
                              },
                              margin: Ei.only(b: 10),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width: itemWidth,
                                padding: Ei.all(10),
                                decoration: CustomDecoration.validator(),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        data.departemen ?? 'Tidak ada',
                                        style: CustomTextStyle.title(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    Obx(() =>
                        CustomLoading().lz.hide(!controller.isPaginate.value)),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
