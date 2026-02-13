import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/surat_menyurat_controller/surat%20menyurat%20hrd/surat_masuk_hrd_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/surat%20masuk/detail_surat_hrd_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class SuratMasukHrdView extends GetView<SuratMasukHrdController> {
  const SuratMasukHrdView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SuratMasukHrdController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(title: 'Surat Masuk').appBar,
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        bool isLoading = controller.isLoading.value;
        final data = controller.surat;

        if (isLoading) {
          return Center(child: CustomLoading());
        }

        if (data.isEmpty) {
          return Empty(
            message: 'Tidak ada Surat Masuk.',
            onTap: () => controller.getData(),
          );
        }

        return LzListView(
          padding: Ei.sym(v: 20, h: 20),
          onRefresh: () => controller.getData(),
          onScroll: (scroll) {
            if (scroll.atBottom(100)) {
              controller.onPaginate();
            }
          },
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchQuery.searchInput(
                    onChanged: controller.updateSearchQuery,
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 20),
            ...data.generate((item, i) {
              return CustomScalaContainer(
                child: Touch(
                  onTap: () {
                    context.openBottomSheet(DetailSuratHrdView(data: item));
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
                          item.userPenerima ?? '-',
                          style: GoogleFonts.poppins().copyWith(
                              color: Colors.white, fontWeight: Fw.bold),
                        ),
                        Text(
                          item.perihal ?? '-',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              item.tglSurat ?? '-',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              ' - ',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              item.sifat ?? '-',
                              style: GoogleFonts.robotoCondensed().copyWith(
                                  color: Colors.white, fontWeight: Fw.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            Obx(() => CustomLoading().lz.hide(!controller.isPaginate.value)),
          ],
        );
      }),
    );
  }
}
