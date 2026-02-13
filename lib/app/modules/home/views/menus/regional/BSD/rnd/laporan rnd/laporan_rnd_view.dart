import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/RND/Laporan%20Kerja%20RND/laporan_rnd_controller.dart';
import 'package:qrm_dev/app/modules/home/controllers/RND/Laporan%20Kerja%20RND/laporan_rnd_minggu_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/laporan%20rnd/create_laporan_kerja_rnd_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/rnd/laporan%20rnd/laporan_rnd_minggu_view.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:qrm_dev/app/widgets/custom_scala_container.dart';
import 'package:qrm_dev/app/widgets/custom_search_query.dart';
import 'package:qrm_dev/app/widgets/transisi/listview_tramsisi.dart';

class LaporanRndView extends GetView<LaporanRndController> {
  const LaporanRndView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LaporanRndController());
    final itemWidth = MediaQuery.of(context).size.width - 30;

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Laporan Kerja RND',
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => CreateLaporanKerjaRndView());
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
                              Get.lazyPut(() => LaporanRndMingguController());
                              Get.to(
                                () => LaporanRndMingguView(
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
