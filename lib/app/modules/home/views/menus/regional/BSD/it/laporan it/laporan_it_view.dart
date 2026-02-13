import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Laporan%20Kerja%20IT/laporan_it_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/IT/Laporan%20Kerja%20IT/laporan_it_minggu_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/laporan%20it/create_laporan_kerja_it_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/it/laporan%20it/laporan_it_minggu_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class LaporanItView extends GetView<LaporanItController> {
  const LaporanItView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LaporanItController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Laporan Kerja',
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => CreateLaporanKerjaItView());
              },
              icon: Icon(Hi.add01))
        ],
      ).appBar,
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        bool isLoading = controller.isLoading.value;
        final data = controller.rk;

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
              padding: Ei.sym(v: 20, h: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SearchQuery.searchInput(
                      onChanged: controller.updateSearchQuery,
                    ),
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
                  ...data.generate((item, i) {
                    return ListItemAnimasi(
                      index: i,
                      beginOffset: const Offset(-0.3, 0),
                      child: CustomScalaContainer(
                        child: Touch(
                          onTap: () {
                            if (item.encryptedMinggu != null) {
                              Get.lazyPut(() => LaporanItMingguController());
                              Get.to(
                                () => LaporanItMingguView(
                                  encryptedMinggu: item.encryptedMinggu!,
                                ),
                              );
                            } else {
                              Toast.show('Data minggu tidak tersedia');
                            }
                          },
                          margin: Ei.only(b: 10),
                          child: Container(
                            width: itemWidth,
                            padding: const EdgeInsets.all(10),
                            decoration: CustomDecoration.validator(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Periode || Week',
                                  style: CustomTextStyle.title(),
                                ),
                                5.height,
                                Text(
                                  '${item.periode ?? '-'} || ${item.minggu ?? '-'}',
                                  style: CustomTextStyle.subtitle(),
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
