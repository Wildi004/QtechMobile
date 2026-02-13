import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/surat_menyurat_controller/surat%20menyurat%20it/surat_masuk_it_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/surat%20masuk/detail_surat_hrd_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class SuratMasukItView extends GetView<SuratMasukItController> {
  const SuratMasukItView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SuratMasukItController());
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
            message: 'Tidak ada data apa pun.',
            onTap: () => controller.getData(),
          );
        }

        return Column(
          children: [
            Padding(
              padding: Ei.sym(v: 10, h: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SearchQuery.searchInput(
                      onChanged: controller.updateSearchQuery,
                    ),
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
                    return ListItemAnimasi(
                      index: i,
                      beginOffset: const Offset(-0.3, 0),
                      child: CustomScalaContainer(
                        child: Touch(
                          onTap: () {
                            context.openBottomSheet(
                                DetailSuratHrdView(data: item));
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
                                  style: CustomTextStyle.title(),
                                ),
                                Text(
                                  item.perihal ?? '-',
                                  style: CustomTextStyle.subtitle(),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      item.tglSurat ?? '-',
                                      style: CustomTextStyle.subtitle(),
                                    ),
                                    Text(
                                      ' - ',
                                      style: CustomTextStyle.subtitle(),
                                    ),
                                    Text(
                                      item.sifat ?? '-',
                                      style: CustomTextStyle.title(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
