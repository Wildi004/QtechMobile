import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/models/surat_masuk/surat_masuk.dart';
import 'package:qrm_dev/app/modules/home/controllers/LEGAL/Surat%20Menyurat%20Legal/surat_keluar_legal_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/HRD/hrd/surat%20masuk/add_surat_hrd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/SCM/operasi%20SCM/legal/surat%20meyurat/detail_surat_keluar_legal_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';

class SuratKeluarLegalView extends GetView<SuratKeluarLegalController> {
  const SuratKeluarLegalView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SuratKeluarLegalController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Surat Keluar',
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => AddSuratHrdView())?.then((data) {
                  if (data != null) {
                    controller.insertData(SuratMasuk.fromJson(data));
                  }
                });
              },
              icon: Icon(Hi.add01))
        ],
      ).appBar,
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        bool isLoading = controller.isLoading.value;
        final data = controller.surat;

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
                    // controller.onPaginate();
                  }
                },
                children: [
                  ...data.generate((item, i) {
                    return CustomScalaContainer(
                      child: Touch(
                        onTap: () {
                          context.openBottomSheet(
                              DetailSuratKeluarLegalView(data: item));
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

/*


 */
